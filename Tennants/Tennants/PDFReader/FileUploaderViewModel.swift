import Foundation
import OSLog

@MainActor
class FileUploaderViewModel: ObservableObject, PDFManager {
    private let repository = RealmRepository()
    private let supabase = SupabaseNetworking()
    let apiManager: ApiDataManager
    let historyManager: HistoryManager

    var fileStoragePath: String?
    let bankTypes: [String] = ["Standard", "FNB", "Capitec"]

    @Published var selectedBankType = "Standard"
    @Published var shouldShowResultView: Bool = false
    @Published var tenantHistoryData: [TenantHistory] = []

    @Published var showPDFImporter: Bool = false
    @Published var isLoading = false
    @Published var isCompleteUploading = false

    @Published var showErrorMessage = false
    @Published var errorMessage = ""

    init() {
        self.apiManager = ApiDataManager(repository: repository)
        self.historyManager = HistoryManager(repository: repository)
        self.getTenantData()
    }

    func handleImportedFile(url: URL) {
        validateFileURL(url) { [weak self] error in
            do {
                let data = try Data(contentsOf: url)
                Task {
                    try? await self?.supabase.uploadFile(fileData: data, userId: "userId", selectedBankType: self?.selectedBankType ?? "Standard")
                    self?.fileStoragePath = self?.supabase.storagePath
                    self?.isLoading = false
                    self?.isCompleteUploading = true
                }
            } catch {
                os_log("Error reading file data: %@", type: .debug, error.localizedDescription)
                self?.showErrorMessage = true
                self?.errorMessage = FileErrorMessages.failedToFetchFile.rawValue
                self?.isCompleteUploading = false
            }
        }
    }

    func handleData() {
        isLoading = true
        self.fetchApiData { [weak self] error in
            if let error {
                os_log("failed to fetch Tenant Payment Info: %@", type: .debug, error.localizedDescription)
                self?.isLoading = false
                self?.showErrorMessage = true
                self?.errorMessage = FileErrorMessages.failedToUploadReferences.rawValue
            } else {
                os_log("Successfully uploaded")
                self?.isLoading = false
            }
        }
    }

    // Try make this a async await
    private func fetchApiData(completion: @escaping (Error?) -> Void) {
        if let fileStoragePath {
            apiManager.fetchApiData(selectedBankType: selectedBankType, userId: "", storagePath: fileStoragePath) { [weak self] data, error in
                if let error {
                    self?.showErrorMessage = true
                    self?.errorMessage = "Failed to process PDF file."
                    completion(error)
                }

                if let data {
                    self?.persistHistoryData(with: data)
                    self?.setUpResultView()
                    completion(nil)
                }
            }
        } else {
            isLoading = false
            showErrorMessage = true
            errorMessage = "Failed to connect to server to process PDF file."
        }
    }

    func setUpResultView() {
        getTenantData()
        shouldShowResultView = true
    }

    func persistHistoryData(with results: [TenantPaymentData]?) {
        historyManager.persistHistoryData(with: results)
    }

    func getTenantData() {
        let allHistoryData = historyManager.fetchData()
        let allTenantData = historyManager.fetchTenantData()
        for history in allHistoryData {
            let data = fetchTenantDataBy(Array(history.results), allTenantData: allTenantData)
            tenantHistoryData.append(TenantHistory(date: history.dateCreated, data: data))
        }
    }

    func fetchTenantDataBy(_ ids: [String], allTenantData: [TenantData]) -> [TenantData] {
        return allTenantData.filter({ ids.contains($0.id) })
    }

    nonisolated func validateFileURL(_ fileURL: URL, completion: @escaping (Error?) -> Void) {
        let fileManager = FileManager.default

        guard fileURL.isFileURL else {
            os_log("The URL is not a file URL.", type: .debug)
            completion(ApiError.fileValidationFailure)
            return
        }

        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                os_log("The URL is a directory.", type: .debug)
                completion(ApiError.fileValidationFailure)
            }

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                os_log("The URL is a symbolic link.", type: .debug)
                completion(ApiError.fileValidationFailure)
            }
        } catch {
            os_log("The URL is invalid or cannot be accessed:", type: .debug, error.localizedDescription)
            completion(ApiError.fileValidationFailure)
        }

        completion(nil)
    }
}

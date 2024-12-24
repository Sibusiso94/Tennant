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
    @Published var errorMessage: FileErrorMessages = .failedToFetchFile

    init() {
        self.apiManager = ApiDataManager(repository: repository)
        self.historyManager = HistoryManager(repository: repository)
        self.getTenantData()
    }

    func handleImportedFile(url: URL) {
        if validateFileURL(url) {
            do {
                let data = try Data(contentsOf: url)
                Task {
                    try? await supabase.uploadFile(fileData: data, userId: "userId", selectedBankType: selectedBankType)
                    self.fileStoragePath = supabase.storagePath
                    self.isLoading = false
                    self.isCompleteUploading = true
                }
            } catch {
                os_log("Error reading file data: %@", type: .debug, error.localizedDescription)
                showErrorMessage = true
                errorMessage = .failedToFetchFile
                isCompleteUploading = false
            }
        }
    }

    func handleData() {
        isLoading = true
        self.fetchApiData { error in
            if let error {
                os_log("failed to fetch Tenant Payment Info: %@", type: .debug, error.localizedDescription)
                self.isLoading = false
                self.showErrorMessage = true
                self.errorMessage = .failedToUploadReferences
            } else {
                os_log("Successfully uploaded")
                self.isLoading = false
            }
        }
    }

    // Try make this a async await
    private func fetchApiData(completion: @escaping (Error?) -> Void) {
        if let fileStoragePath {
            apiManager.fetchApiData(selectedBankType: selectedBankType, userId: "", storagePath: fileStoragePath) { [weak self] data, error in
                if let error {
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

    nonisolated func validateFileURL(_ fileURL: URL) -> Bool {
        let fileManager = FileManager.default

        guard fileURL.isFileURL else {
            os_log("The URL is not a file URL.", type: .debug)
            return false
        }

        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                os_log("The URL is a directory.", type: .debug)
                return false
            }

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                os_log("The URL is a symbolic link.", type: .debug)
                return false
            }
        } catch {
            os_log("The URL is invalid or cannot be accessed:", type: .debug, error.localizedDescription)
            return false
        }

        return true
    }
}

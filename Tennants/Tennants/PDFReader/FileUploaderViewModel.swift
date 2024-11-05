import Foundation
import OSLog

class FileUploaderViewModel: ObservableObject, PDFManager {
    let repository = RealmRepository()
    var validationManager = ValidationManager()
    let apiManager: ApiDataManager
    let historyManager:  HistoryManager

    var fileStoragePath: String?
    let bankTypes: [String] = ["Standard", "FNB", "Capitec"]
    var reference = "STANSAL"

    @Published var selectedBankType = "Standard"
    @Published var shouldShowResultView: Bool = false
    @Published var tenantHistoryData: [TenantHistory] = []

    @Published var showPDFImporter: Bool = false
    @Published var isLoading = false

    init() {
        self.apiManager = ApiDataManager(repository: repository)
        self.historyManager = HistoryManager(repository: repository)
        self.getTenantData()
    }

    func handleImportedFile(url: URL) {
        if validationManager.validateFileURL(url) {
            do {
                let data = try Data(contentsOf: url)
                apiManager.uploadFile(url: data, bankType: selectedBankType) { [weak self] storagePath, error in
                    if let error = error {
                        os_log("Failed to upload: %@", type: .debug, error.localizedDescription)
                        #warning("Create error message")
                        return
                    }
                    self?.fileStoragePath = storagePath
                    print("Successfully added")
                    self?.isLoading = false
                }
            } catch {
                os_log("Error reading file data: %@", type: .debug, error.localizedDescription)
            }
        }
    }

    func fetchApiData() {
        isLoading = true
        
        if let fileStoragePath {
            apiManager.fetchApiData(selectedBankType: selectedBankType, reference: reference, storagePath: fileStoragePath) { [weak self] data, error in
                if let data {
                    self?.persistHistoryData(with: data)
                    self?.setUpResultView()
                    self?.isLoading = false
                }

                if let error {
                    print(error)
                }
            }
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
}

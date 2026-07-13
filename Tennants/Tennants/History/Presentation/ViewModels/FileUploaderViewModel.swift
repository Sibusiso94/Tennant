import Foundation
import OSLog

@MainActor
class FileUploaderViewModel: ObservableObject {
    private let tenantPaymentUseCase: TenantPaymentProtocol

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

    init(tenantPaymentUseCase: TenantPaymentProtocol) {
//        self.getTenantData()
        self.tenantPaymentUseCase = tenantPaymentUseCase
    }

    func getTenantPaymentInfo() {
        Task {
            do {
                try await tenantPaymentUseCase.getPaymentData(
                    selectedBankType: selectedBankType,
                    userId: ""
                )
            } catch {
                errorMessage = ""
            }
        }
    }

    func handleImportedFile(url: URL) {
        Task {
            do {
                try await tenantPaymentUseCase.handleImportedFile(
                    url: url,
                    selectedBankType: selectedBankType,
                    userId: "")
            } catch {
                errorMessage = ""
            }
        }
    }

    func setUpResultView() {
//        getTenantData()
        shouldShowResultView = true
    }

    func fetchTenantDataBy(_ ids: [String], allTenantData: [TenantData]) -> [TenantData] {
        return allTenantData.filter({ ids.contains($0.id) })
    }
}

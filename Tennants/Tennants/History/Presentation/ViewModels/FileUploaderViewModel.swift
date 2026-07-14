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
        guard let readURL = resolveSecurityScopedURL(url) else {
            isLoading = false
            return
        }

        Task {
            do {
                try await tenantPaymentUseCase.handleImportedFile(
                    url: readURL,
                    selectedBankType: selectedBankType,
                    userId: "")
                print("Document:")
                print(readURL)
            } catch {
                errorMessage = ""
                print("Document error:")
                print(error)
            }
        }
    }

    private func resolveSecurityScopedURL(_ url: URL) -> URL? {
        guard url.startAccessingSecurityScopedResource() else {
            os_log("Failed to access security scoped resource.", type: .error)
            return nil
        }
        defer { url.stopAccessingSecurityScopedResource() }

        var coordinatorError: NSError?
        var resolvedURL: URL?
        NSFileCoordinator().coordinate(readingItemAt: url, error: &coordinatorError) { readURL in
            resolvedURL = readURL
        }

        if let coordinatorError {
            os_log("File coordination failed: %{public}@", type: .error, coordinatorError.localizedDescription)
        }

        return resolvedURL
    }

    func setUpResultView() {
//        getTenantData()
        shouldShowResultView = true
    }

    func fetchTenantDataBy(_ ids: [String], allTenantData: [TenantData]) -> [TenantData] {
        return allTenantData.filter({ ids.contains($0.id) })
    }
}

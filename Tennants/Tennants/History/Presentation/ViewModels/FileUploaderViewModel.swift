import Foundation
import OSLog

@MainActor
@Observable
class FileUploaderViewModel {
    private let tenantPaymentUseCase: TenantPaymentProtocol

    @ObservationIgnored weak var coordinator: (any Coordinator<HistoryRoute>)?

    var fileStoragePath: String?
    let bankTypes: [String] = ["Standard", "FNB", "Capitec"]

    var selectedBankType = "Standard"
    var tenantHistoryData: [TenantHistory] = []

    var showPDFImporter: Bool = false
    var isLoading = false
    var isCompleteUploading = false

    var showErrorMessage = false
    var errorMessage = ""

    init(tenantPaymentUseCase: TenantPaymentProtocol) {
//        self.getTenantData()
        self.tenantPaymentUseCase = tenantPaymentUseCase
    }

    convenience init() {
        let useCase = DIContainer.shared.resolve(TenantPaymentProtocol.self)
        self.init(tenantPaymentUseCase: useCase)
    }

    func handleImportedFile(url: URL) {
        guard let readURL = resolveSecurityScopedURL(url) else {
            isLoading = false
            return
        }

        Task {
            do {
                try await tenantPaymentUseCase.uploadDocument(
                    url: readURL,
                    selectedBankType: selectedBankType,
                    userId: "")

                isCompleteUploading = true

                try await getTenantPaymentInfo()
            } catch {
                errorMessage = ""
            }
        }
    }

    private func getTenantPaymentInfo() async throws {
            do {
                try await tenantPaymentUseCase.getPaymentData(
                    selectedBankType: selectedBankType,
                    userId: ""
                )
            } catch {
                errorMessage = ""
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

    func showHistory() {
        Task { [weak self] in
            try? await self?.coordinator?.route(to: .paymentHistory)
        }
    }

    func fetchTenantDataBy(_ ids: [String], allTenantData: [TenantData]) -> [TenantData] {
        return allTenantData.filter({ ids.contains($0.id) })
    }
}

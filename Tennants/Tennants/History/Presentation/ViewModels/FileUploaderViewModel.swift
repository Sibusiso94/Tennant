import Foundation
import OSLog

enum ViewState {
    case loading
    case loaded
    case error(message: String)
}

@MainActor
@Observable
class FileUploaderViewModel {
    private let tenantPaymentUseCase: TenantPaymentProtocol
    var state: ViewState = .loaded

    @ObservationIgnored weak var coordinator: (any Coordinator<HistoryRoute>)?

    var fileStoragePath: String?
    let bankTypes: [String] = ["Standard", "FNB", "Capitec"]

    var selectedBankType = "Standard"
    var tenantHistoryData: [TenantHistory] = []

    var showPDFImporter: Bool = false
    var isCompleteUploading = false

    var showErrorMessage = false

    init(tenantPaymentUseCase: TenantPaymentProtocol) {
        self.tenantPaymentUseCase = tenantPaymentUseCase
    }

    convenience init() {
        let useCase = DIContainer.shared.resolve(TenantPaymentProtocol.self)
        self.init(tenantPaymentUseCase: useCase)
    }

    func handleImportedFile(url: URL) {
        state = .loading
        guard let readURL = resolveSecurityScopedURL(url) else {
            state = .error(message: "Something went wrong\nPlease try again later")
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
                state = .loaded
            } catch {
                state = .error(message: "Something went wrong\nPlease try again later")
            }
        }
    }

    private func getTenantPaymentInfo() async throws {
        try await tenantPaymentUseCase.getPaymentData(
            selectedBankType: selectedBankType,
            userId: ""
        )
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

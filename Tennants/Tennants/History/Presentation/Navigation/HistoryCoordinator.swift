import SwiftUI
import Combine

// MARK: - Routes

/// Navigation intents for the History (Update / file upload) tab.
enum HistoryRoute {
    case paymentHistory
    case popToRoot
}

/// Destinations pushed onto the tab's `NavigationStack`.
enum HistoryDestination: Hashable {
    case paymentHistory
}

// MARK: - Coordinator

@MainActor
final class HistoryCoordinator: Coordinator {
    let factory: AppFactory

    private(set) var viewModel: FileUploaderViewModel!

    @Published var path: [HistoryDestination] = []

    init(factory: AppFactory) {
        self.factory = factory
        self.viewModel = factory.makeFileUploaderViewModel(coordinator: self)
    }

    func route(to route: HistoryRoute) async throws {
        switch route {
        case .paymentHistory:
            path.append(.paymentHistory)
        case .popToRoot:
            path.removeAll()
        }
    }
}

// MARK: - Factory

extension AppFactory {
    func makeFileUploaderViewModel(coordinator: any Coordinator<HistoryRoute>) -> FileUploaderViewModel {
        let viewModel = FileUploaderViewModel()
        viewModel.coordinator = coordinator
        return viewModel
    }

    @ViewBuilder
    func makeFileUploaderView(viewModel: FileUploaderViewModel) -> some View {
        FileUploaderView(viewModel: viewModel)
    }

    @ViewBuilder
    func makePaymentHistoryView(viewModel: FileUploaderViewModel) -> some View {
        PaymentHistoryView(history: viewModel.tenantHistoryData)
    }
}

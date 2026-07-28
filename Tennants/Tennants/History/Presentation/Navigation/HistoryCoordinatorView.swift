import SwiftUI

/// Owns the `NavigationStack` for the History tab and resolves destinations via
/// the factory.
struct HistoryCoordinatorView: View {
    @StateObject private var coordinator: HistoryCoordinator
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
        _coordinator = StateObject(wrappedValue: HistoryCoordinator(factory: factory))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            factory.makeFileUploaderView(viewModel: coordinator.viewModel)
                .navigationDestination(for: HistoryDestination.self) { destination in
                    switch destination {
                    case .paymentHistory:
                        factory.makePaymentHistoryView(viewModel: coordinator.viewModel)
                    }
                }
        }
    }
}

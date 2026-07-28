import SwiftUI

/// Owns the `NavigationStack` for the Tenants tab and resolves destinations via
/// the factory.
struct TenantsCoordinatorView: View {
    @StateObject private var coordinator: TenantsCoordinator
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
        _coordinator = StateObject(wrappedValue: TenantsCoordinator(factory: factory))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            factory.makeTenantListView(viewModel: coordinator.viewModel)
                .navigationDestination(for: TenantsDestination.self) { destination in
                    switch destination {
                    case .tenantDetail:
                        factory.makeTenantDetailView(coordinator: coordinator)
                    }
                }
        }
    }
}

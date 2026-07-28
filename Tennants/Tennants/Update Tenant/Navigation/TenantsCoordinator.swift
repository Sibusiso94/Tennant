import SwiftUI
import Combine

// MARK: - Routes

/// Navigation intents for the Tenants (Update Tenant) tab.
enum TenantsRoute {
    case tenantDetail
    case popToRoot
}

/// Destinations pushed onto the tab's `NavigationStack`.
enum TenantsDestination: Hashable {
    case tenantDetail
}

// MARK: - Coordinator

@MainActor
final class TenantsCoordinator: Coordinator {
    let factory: AppFactory

    private(set) var viewModel: TenantListViewModel!

    @Published var path: [TenantsDestination] = []

    init(factory: AppFactory) {
        self.factory = factory
        self.viewModel = factory.makeTenantListViewModel(coordinator: self)
    }

    func route(to route: TenantsRoute) async throws {
        switch route {
        case .tenantDetail:
            path.append(.tenantDetail)
        case .popToRoot:
            path.removeAll()
        }
    }
}

// MARK: - Factory

extension AppFactory {
    func makeTenantListViewModel(coordinator: any Coordinator<TenantsRoute>) -> TenantListViewModel {
        let viewModel = TenantListViewModel()
        viewModel.coordinator = coordinator
        return viewModel
    }

    @ViewBuilder
    func makeTenantListView(viewModel: TenantListViewModel) -> some View {
        TenantListView(viewModel: viewModel)
    }

    @ViewBuilder
    func makeTenantDetailView(coordinator: TenantsCoordinator) -> some View {
        let tenant = coordinator.viewModel.selectedTenant
        TenantDetailView(tenant: tenant, unitNumber: "\(tenant.unitID)")
    }
}

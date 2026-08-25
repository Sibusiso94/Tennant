import Foundation

@Observable
class TenantListViewModel {
    let manager: TenantManagerProtocol

    @ObservationIgnored weak var coordinator: (any Coordinator<TenantsRoute>)?

    var allTenants = [Tennant]()
    var selectedTenant = Tennant()
    var searchText = ""

    init(manager: TenantManagerProtocol) {
        self.manager = manager
        fetch()
    }

    convenience init() {
        let manager = DIContainer.shared.resolve(TenantManagerProtocol.self)
        self.init(manager: manager)
    }

    func fetch() {
        allTenants = manager.fetchTenants()
        print(allTenants[0].name)
    }

    func didSelectTenant(_ tenant: Tennant) {
        selectedTenant = tenant
        Task { [weak self] in
            try? await self?.coordinator?.route(to: .tenantDetail)
        }
    }
}

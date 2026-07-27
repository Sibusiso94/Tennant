import Foundation

@Observable
class TenantListViewModel {
    let manager: TenantManagerProtocol

    var allTenants = [Tennant]()
    var selectedTenant = Tennant()
    var searchText = ""
    var showDetailView = false

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
    }
}

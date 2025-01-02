import Foundation

class TenantListViewModel: ObservableObject {
    let repository: RealmRepository
    let manager: TenantManager

    @Published var allTenants = [Tennant]()
    @Published var selectedTenant = Tennant()
    @Published var searchText = ""
    @Published var showDetailView = false

    init() {
        self.repository = RealmRepository()
        self.manager = TenantManager(repository: repository)
        fetch()
    }

    func fetch() {
        allTenants = manager.fetchAll()
    }
}

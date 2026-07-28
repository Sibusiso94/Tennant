import SwiftUI

struct TenantTabView: View {
    @State private var selectedTab = TenantTabItem.home
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            factory.makePropertiesCoordinatorView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Flats")
                }
                .tag(TenantTabItem.home)

            factory.makeTenantsCoordinatorView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Tenants")
                }
                .tag(TenantTabItem.tenants)

            factory.makeHistoryCoordinatorView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Update")
                }
                .tag(TenantTabItem.update)
        }
    }
}

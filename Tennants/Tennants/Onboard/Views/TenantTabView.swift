import SwiftUI

struct TenantTabView: View {
    @State var selectedTab = TenantTabItem.home

    var body: some View {
        TabView(selection: $selectedTab) {
            PropertiesView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Flats")
                }
                .tag(TenantTabItem.home)

            TenantListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Tenants")
                }
                .tag(TenantTabItem.tenants)

            FileUploaderView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Update")
                }
                .tag(TenantTabItem.update)
        }
    }
}

#Preview {
    TenantTabView()
}

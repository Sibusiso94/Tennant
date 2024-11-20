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

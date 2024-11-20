import SwiftUI

struct TennantTabView: View {
    @State var selectedTab = TennantTabItem.home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PropertiesView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Flats")
                }
                .tag(TennantTabItem.home)
            
            FileUploaderView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("Update")
                }
                .tag(TennantTabItem.update)
        }
    }
}

#Preview {
    TennantTabView()
}

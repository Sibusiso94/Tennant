import SwiftUI

struct TennantTabView: View {
    @State var selectedTab = TennantTabItem.flats
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TennantLandingView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Flats")
                }
                .tag(TennantTabItem.flats)
            
            Text("Tennants")
                .tabItem {
                    Image(systemName: "person")
                    Text("Tennants")
                }
                .tag(TennantTabItem.tennants)
        }
    }
}

#Preview {
    TennantTabView()
}

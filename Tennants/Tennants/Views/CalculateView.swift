import SwiftUI

struct CalculateView: View {
    @Binding var selectedTab: TennantTabItem
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            showAlert = true
        }
        .alert("Choose Option", isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Upload Statement")
            }
            
            Button {
                
            } label: {
                Text("Update a Tennant")
            }
            
            Button("Cancel", role: .cancel) {
                selectedTab = .home
            }
        }
    }
}

#Preview {
    CalculateView(selectedTab: .constant(TennantTabItem.update))
}

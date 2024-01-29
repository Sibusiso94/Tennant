import SwiftUI

struct AlertButtons: View {
    @Binding var selectedTab: TennantTabItem
    @Binding var showCalculateView: CalculateViewStates
    
    var body: some View {
        Button {
            showCalculateView = .uploadFile
        } label: {
            Text("Upload Statement")
        }
        
        Button {
            showCalculateView = .updateTennant
        } label: {
            Text("Update a Tennant")
        }
        
        Button("Cancel", role: .cancel) {
            selectedTab = .home
        }
    }
}

#Preview {
    AlertButtons(selectedTab: .constant(TennantTabItem.update), showCalculateView: .constant(CalculateViewStates.updateTennant))
}

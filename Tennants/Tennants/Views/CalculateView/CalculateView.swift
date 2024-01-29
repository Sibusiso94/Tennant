import SwiftUI

struct CalculateView: View {
    @StateObject var viewModel = CalculateViewViewModel()
    @Binding var selectedTab: TennantTabItem
    
    var body: some View {
        VStack {
            switch viewModel.showCalculateView {
            case .updateTennant:
                Text("Update Tennant")
            case .uploadFile:
                Text("Upload Statement")
            }
        }
        .onAppear {
            viewModel.showAlert = true
        }
        .alert("Choose Option", isPresented: $viewModel.showAlert) {
            AlertButtons(selectedTab: $selectedTab,
                         showCalculateView: $viewModel.showCalculateView)
        }
    }
}

#Preview {
    CalculateView(selectedTab: .constant(TennantTabItem.update))
}

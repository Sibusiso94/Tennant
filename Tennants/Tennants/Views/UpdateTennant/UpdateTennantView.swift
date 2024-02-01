import SwiftUI

struct UpdateTennantView: View {
    @FocusState var isInputActive: Bool
    @StateObject var viewModel = UpdateTennantViewModel()
    
    init() { }
    
    var body: some View {
        NavigationStack {
            VStack {
                UpdateTennantTopCardView(tennant: viewModel.selectedTennant)
                    .padding(.top)
                
                CircularProgressView(progress: viewModel.getPaymentHistoryPercentage())
                    .frame(width: 200, height: 200)
                
                // Add done button and tap to dismiss
                TextField(" Amount paid", text: $viewModel.amountAdded)
                    .frame(height: 50)
                    .buttonHorizontalPadding()
                    .padding(.top)
                    .keyboardType(.numberPad)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Paid in full")
                        .padding()
                }
                .buttonHorizontalPadding()
                
                Button {
                    
                } label: {
                    Text("Add payment")
                        .padding()
                }
                .buttonHorizontalPadding()
                .disabled(viewModel.amountAdded == "")
                
                Spacer()
            }
            .background {
                Color("PastelGrey")
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

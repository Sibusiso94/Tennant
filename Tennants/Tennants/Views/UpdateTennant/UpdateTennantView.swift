import SwiftUI

struct UpdateTennantView: View {
    @FocusState var isInputActive: Bool
    @StateObject var viewModel = UpdateTennantViewModel()
    @State var paymentHistoryPercentage = 0.0
    
    init() { }
    
    var body: some View {
        NavigationStack {
            VStack {
                UpdateTennantTopCardView(tennant: viewModel.selectedTennant)
                    .padding(.top)
                
                CircularProgressView(progress: paymentHistoryPercentage,
                                     percentageString: viewModel.getPercentage(percentageDouble: paymentHistoryPercentage))
                    .frame(width: 200, height: 200)
                
                TextField(" Amount paid", text: $viewModel.amountAdded)
                    .numberTextField()
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Paid in full")
                        .padding()
                }
                .customHorizontalPadding(isButton: true)
                
                Button {
                    
                } label: {
                    Text("Add payment")
                        .padding()
                }
                .customHorizontalPadding(isButton: true)
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
            .onAppear {
                viewModel.getNumberOfMonthsPassed(startDate: viewModel.selectedTennant.startDate, endDate: Date.now)
                paymentHistoryPercentage = viewModel.getPaymentHistoryPercentage(numberOfMonthsPassed: viewModel.numberOfMonthsPassed,
                                                                                 numberOfFullPayments: viewModel.selectedTennant.fullPayments)
            }
        }
    }
}

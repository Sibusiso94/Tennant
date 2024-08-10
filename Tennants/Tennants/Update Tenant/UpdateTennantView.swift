import SwiftUI
import MyLibrary

struct UpdateTennantView: View {
    @FocusState var isInputActive: Bool
    @StateObject var viewModel = UpdateTennantViewModel()
    @State var paymentHistoryPercentage = 0.0
    @Binding var tenant: Tennant
    
    init(tenant: Binding<Tennant>) {
        self._tenant = tenant
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                UpdateTennantTopCardView(unitNumber: tenant.unitID,
                                         name: tenant.name,
                                         surname: tenant.surname,
                                         balance: "\(tenant.balance)",
                                         amountDue: "\(tenant.amountDue)")
                    .padding(.horizontal)
                
                CircularProgressView(progress: 0.7,
                                     percentageString: viewModel.getPercentage(percentageDouble: paymentHistoryPercentage), lineWidth: 20)
                    .frame(width: 150, height: 150)
                    .padding(.vertical)
                
                TextField("Amount paid", text: $viewModel.amountAdded)
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
                
                CustomTextButton(title: "Paid in full") {
                    //
                }
//                Button {
//                    
//                } label: {
//                    Text()
//                        .padding()
//                }
//                .customHorizontalPadding(isButton: true)
                
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

#Preview {
    UpdateTennantView(tenant: .constant(MockTenants.tenants[0]))
}

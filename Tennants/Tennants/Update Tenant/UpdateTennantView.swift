import SwiftUI
import MyLibrary

struct UpdateTennantView: View {
    @FocusState var isInputActive: Bool
    @StateObject var viewModel = UpdateTennantViewModel()
    @State var paymentHistoryPercentage = 0.0
    @Binding var tenant: Tennant
    @Binding var path: NavigationPath
    
    init(tenant: Binding<Tennant>, _ path: Binding<NavigationPath>) {
        self._tenant = tenant
        self._path = path
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
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        path.removeLast()
//                    } label: {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Back")
//                        }
//                    }
//                }
//            }
            .toolbar {
                CustomMenuButton {
                    //
                } option2Action: {
                    //
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

//#Preview {
//    UpdateTennantView(tenant: .constant(MockTenants.tenants[0]))
//}

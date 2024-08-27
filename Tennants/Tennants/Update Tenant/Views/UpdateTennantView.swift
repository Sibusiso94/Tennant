import SwiftUI
import MyLibrary

struct UpdateTennantView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState var isInputActive: Bool
    @StateObject var viewModel = UpdateTennantViewModel()
    
    @State var paymentHistoryPercentage = 0.0
    @State var showEditView: Bool = false
    @Binding var tenant: Tennant
    
    var unit: SingleUnit
    
    init(tenant: Binding<Tennant>, unit: SingleUnit) {
        self._tenant = tenant
        self.unit = unit
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                UpdateTennantTopCardView(unitNumber: String(unit.unitNumber),
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
//                        dismiss()
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
                    // show add Tennant
                } option2Action: {
                    //
                }

            }
            .onAppear {
                viewModel.getNumberOfMonthsPassed(startDate: viewModel.selectedTennant.startDate, endDate: Date.now)
                paymentHistoryPercentage = viewModel.getPaymentHistoryPercentage(numberOfMonthsPassed: viewModel.numberOfMonthsPassed,
                                                                                 numberOfFullPayments: Int(viewModel.selectedTennant.fullPayments) ?? 0)
            }
//            .navigationDestination(isPresented: $showEditView) {
//                withAnimation {
//                    AddTenantView {
//                        //
//                    }
//                }
//            }
        }
    }
}

//#Preview {
//    UpdateTennantView(tenant: .constant(MockTenants.tenants[0]))
//}

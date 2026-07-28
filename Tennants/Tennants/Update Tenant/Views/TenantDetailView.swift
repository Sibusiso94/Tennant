import SwiftUI
import MyLibrary

struct TenantDetailView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState var isInputActive: Bool
    @State var viewModel = UpdateTennantViewModel()

    @State var paymentHistoryPercentage = 0.0
    @State var showEditView: Bool = false
    @State var isEditingTenant: Bool = false

    var tenant: Tennant
    var unitNumber: String
    
    init(tenant: Tennant, unitNumber: String) {
        self.tenant = tenant
        self.unitNumber = unitNumber
    }
    
    var body: some View {
        VStack {
            UpdateTennantTopCardView(unitNumber: unitNumber,
                                     name: tenant.name,
                                     surname: tenant.surname,
                                     balance: "\(tenant.balance)",
                                     amountDue: "\(tenant.amountDue)",
                                     isOccupied: true)
                .padding(.horizontal)

            CircularProgressView(progress: 0.7,
                                 percentageString: viewModel.getPercentage(percentageDouble: paymentHistoryPercentage), lineWidth: 20)
                .frame(width: 150, height: 150)
                .padding(.vertical)

            if isEditingTenant {
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

                Button {

                } label: {
                    Text("Add payment")
                        .padding()
                }
                .customHorizontalPadding(isButton: true)
                .disabled(viewModel.amountAdded == "")
            }

            Spacer()
        }
        .background {
            Color("PastelGrey")
                .ignoresSafeArea()
        }
        .toolbar {
            CustomMenuButton {
                // show add Tennant
            } option2Action: {
                //
            }

        }
    }
}

//#Preview {
//    UpdateTennantView(tenant: .constant(MockTenants.tenants[0]))
//}

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
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    TenantDetailTopCardView()

                    TenantDetailInfoCardView(
                        image: TenantStrings.PropertyInfo.image.rawValue,
                        mainTitle: TenantStrings.PropertyInfo.mainTitle.rawValue,
                        details: [(title: TenantStrings.PropertyInfo.propertyName.rawValue, name: "Tereso"), (title: TenantStrings.PropertyInfo.unitNumber.rawValue, name: "1")]
                    )

                    TenantDetailInfoCardView(
                        image: TenantStrings.EmploymentInfo.image.rawValue,
                        mainTitle: TenantStrings.EmploymentInfo.mainTitle.rawValue,
                        details: [(title: TenantStrings.EmploymentInfo.company.rawValue, name: "TechNova Solutions"), (title: TenantStrings.EmploymentInfo.position.rawValue, name: "Software Developer"), (title: TenantStrings.EmploymentInfo.monthlyIncome.rawValue, name: "R 45,000.00")]
                    )

                    TenantDetailInfoCardView(
                        image: TenantStrings.FinancialOverview.image.rawValue,
                        mainTitle: TenantStrings.FinancialOverview.mainTitle.rawValue,
                        details: [(title: TenantStrings.FinancialOverview.balance.rawValue, name: "Tereso"), (title: TenantStrings.FinancialOverview.amountDue.rawValue, name: "1")]
                    )

                    TenantDetailInfoCardView(
                        image: TenantStrings.TenancyPeriod.image.rawValue,
                        mainTitle: TenantStrings.TenancyPeriod.mainTitle.rawValue,
                        details: [(title: TenantStrings.TenancyPeriod.startDate.rawValue, name: "01 May 2024"), (title: TenantStrings.TenancyPeriod.endDate.rawValue, name: "31 April 2027")]
                    )

                    Button {

                    } label: {
                        HStack {
                            Image(systemName: "envelope")
                            Text("Contact Tenant")
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("DarkPastelBlue"))
                    .foregroundStyle(Color.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))

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
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .toolbar {
                CustomMenuButton {
                    // show add Tennant
                } option2Action: {
                    //
                }
            }
            .navigationTitle("Tenant Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TenantDetailView(tenant: MockTenants.tenants[0], unitNumber: "1")
}

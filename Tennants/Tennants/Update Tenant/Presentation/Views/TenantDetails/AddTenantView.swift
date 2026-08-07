import SwiftUI
import MyLibrary

struct AddTenantView: View {
    @FocusState private var focusedTennantField: TennantField?
    @Environment(\.dismiss) var dismiss

    @State private var viewModel = AddTenantViewModel()

    var propertyId: String
    var unitId: String
    
    init(propertyId: String,
         unitId: String
    ) {
        self.propertyId = propertyId
        self.unitId = unitId
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        CustomTextField(text: $viewModel.tenant.name, placeHolderText: "Name")
                            .focused($focusedTennantField, equals: .name)
                            .onSubmit { self.focusNextField($focusedTennantField) }


                        CustomTextField(text: $viewModel.tenant.surname, placeHolderText: "Surname")
                                .focused($focusedTennantField, equals: .name)
                                .onSubmit { self.focusNextField($focusedTennantField) }

                        CustomTextField(text: $viewModel.tenant.currentAddress, placeHolderText: "Address")
                            .focused($focusedTennantField, equals: .address)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $viewModel.tenant.reference, placeHolderText: "Reference")
                            .focused($focusedTennantField, equals: .reference)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $viewModel.tenant.tennantID, placeHolderText: "ID Number")
                            .focused($focusedTennantField, equals: .tennantID)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        if viewModel.showErrorMessage {
                            HStack {
                                ErrorMessageView(errorMessage: ErrorMessage.tenantIDError.rawValue)
                                Spacer()
                            }
                        }
                        
                        CustomTextField(text: $viewModel.tenant.company, placeHolderText: "Company")
                            .focused($focusedTennantField, equals: .company)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $viewModel.tenant.position, placeHolderText: "Position")
                            .focused($focusedTennantField, equals: .position)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $viewModel.tenant.monthlyIncome, placeHolderText: "Monthly Income")
                            .focused($focusedTennantField, equals: .monthlyIncome)
                            .onSubmit { self.focusNextField($focusedTennantField) }

                        VStack {
                            DatePicker("Start date:", selection: $viewModel.startDate, displayedComponents: .date)
                            DatePicker("End date:", selection: $viewModel.endDate, displayedComponents: .date)
                        }
                        .padding(.horizontal)

                        
                        Button {
                            viewModel.addTenant(propertyID: propertyId, unitID: unitId)
                        } label: {
                            Text("Add Tenant")
                                .padding()
                        }
                        .customHorizontalPadding(isButton: true)
                        Spacer()
                        
                    }
                    .navigationTitle("Add Tenant")
                }
                .alert("Tenant successfully added", isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                }
            }
        .foregroundStyle(.black.opacity(0.8))
        .onAppear {
            viewModel.dateOneYearFromNow()
        }
    }
}


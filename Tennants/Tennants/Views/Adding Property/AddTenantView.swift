import SwiftUI

struct AddTenantView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedTennantField: TennantField?
    
    @Environment(\.dismiss) var dismiss
    @Binding var data: NewDataModel
    @State var showErrorMessage: Bool
    
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         action: @escaping () -> Void) {
        self._data = data
        self.action = action
        _showErrorMessage = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    TextFormView { validate in
                        VStack(spacing: 25) {
                            CustomTextField(text: $data.name, placeHolderText: "Name")
                                .focused($focusedTennantField, equals: .name)
                                .onSubmit { self.focusNextField($focusedTennantField) }
                            
                            CustomTextField(text: $data.address, placeHolderText: "Address")
                                .focused($focusedTennantField, equals: .address)
                                .onSubmit { self.focusNextField($focusedTennantField) }
                            
                            HStack(spacing: 0) {
                                CustomTextField(text: $data.buildingNumber, placeHolderText: "Building Number")
                                CustomTextField(text: $data.flatNumber, placeHolderText: "Flat Number")
                            }
                            
                            CustomValidatedNumberField(text: $data.tennantID,
                                                       placeHolderText: "ID Number",
                                                       numberOfUnits: data.numberOfUnits, isProperty: false)
                            .focused($focusedTennantField, equals: .tennantID)
                            .onSubmit {
                                if !validate() {
                                    print("Validated!!!")
                                } else {
                                    self.focusNextField($focusedTennantField)
                                }
                            }
                            
                            if showErrorMessage {
                                HStack {
                                    ErrorMessageView(errorMessage: ErrorMessage.tenantIDError)
                                    Spacer()
                                }
                            }
                            
                            CustomTextField(text: $data.company, placeHolderText: "Company")
                                .focused($focusedTennantField, equals: .company)
                                .onSubmit { self.focusNextField($focusedTennantField) }
                            
                            CustomTextField(text: $data.position, placeHolderText: "Position")
                                .focused($focusedTennantField, equals: .position)
                                .onSubmit { self.focusNextField($focusedTennantField) }
                            
                            CustomTextField(text: $data.monthlyIncome, placeHolderText: "Monthly Income")
                                .focused($focusedTennantField, equals: .monthlyIncome)
                                .onSubmit { self.focusNextField($focusedTennantField) }
                            
                            Button {
                                if !validate() {
                                    showErrorMessage = true
                                } else {
                                    data.isAProperty = false
                                    action()
                                }
                            } label: {
                                Text("Add another Tenant")
                                    .padding()
                            }
                            .customHorizontalPadding(isButton: true)
                            //            .disabled(viewModel.amountAdded == "")
                            Spacer()
                            
                        }
                        .navigationTitle("Add Tenant")
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Cancel") {
                                    dismiss()
                                }
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Done") {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    AddTenantView(data: .constant(NewDataModel()), action: {})
}


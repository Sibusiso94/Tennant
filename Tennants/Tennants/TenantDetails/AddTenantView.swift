import SwiftUI
import MyLibrary

struct AddTenantView: View {
    @FocusState private var focusedTennantField: TennantField?
    @Environment(\.dismiss) var dismiss
    
    @State var tenant = Tennant()
    @State var showErrorMessage: Bool
    @State var showAlert: Bool
    
    var action: (Tennant) -> Void
    
    init(action: @escaping (Tennant) -> Void) {
        self.action = action
        _showErrorMessage = State(initialValue: false)
        _showAlert = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        CustomTextField(text: $tenant.name, placeHolderText: "Name")
                            .focused($focusedTennantField, equals: .name)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $tenant.currentAddress, placeHolderText: "Address")
                            .focused($focusedTennantField, equals: .address)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $tenant.reference, placeHolderText: "Reference")
                            .focused($focusedTennantField, equals: .reference)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $tenant.tennantID, placeHolderText: "ID Number")
                            .focused($focusedTennantField, equals: .tennantID)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        if showErrorMessage {
                            HStack {
                                ErrorMessageView(errorMessage: ErrorMessage.tenantIDError.rawValue)
                                Spacer()
                            }
                        }
                        
                        CustomTextField(text: $tenant.company, placeHolderText: "Company")
                            .focused($focusedTennantField, equals: .company)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $tenant.position, placeHolderText: "Position")
                            .focused($focusedTennantField, equals: .position)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $tenant.monthlyIncome, placeHolderText: "Monthly Income")
                            .focused($focusedTennantField, equals: .monthlyIncome)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        
                        Button {
//                            if !validate() {
//                                showErrorMessage = true
//                            } else {
                            showAlert = true
//                            }
                        } label: {
                            Text("Add another Tenant")
                                .padding()
                        }
                        .customHorizontalPadding(isButton: true)
                        Spacer()
                        
                    }
                    .navigationTitle("Add Tenant")
                }
                .alert("Tenant successfully added", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        action(tenant)
                        dismiss()
                    }
                }
            }
            .foregroundStyle(.black.opacity(0.8))
        }
    }
    
    func checkIDNumber(text: String) -> Bool {
        if text.count == 13 {
            return true
        } else {
            return false
        }
    }
}


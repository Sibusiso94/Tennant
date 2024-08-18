import SwiftUI
import MyLibrary

struct AddTenantView: View {
    @FocusState private var focusedTennantField: TennantField?
    @StateObject var viewModel = AddTenantViewModel()
    @State var showErrorMessage: Bool
    
    var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        _showErrorMessage = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        CustomTextField(text: $viewModel.tenant.name, placeHolderText: "Name")
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
                        
                        if showErrorMessage {
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
                        
                        
                        Button {
//                            if !validate() {
//                                showErrorMessage = true
//                            } else {
                                action()
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


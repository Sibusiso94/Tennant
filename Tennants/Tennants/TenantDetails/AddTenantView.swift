import SwiftUI
import MyLibrary

struct AddTenantView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedTennantField: TennantField?
    
    @Binding var data: NewDataModel
    @State var showErrorMessage: Bool
    
    var selectedUnit: SingleUnit
    
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         selectedUnit: SingleUnit,
         action: @escaping () -> Void) {
        self._data = data
        self.selectedUnit = selectedUnit
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
                        CustomTextField(text: $data.name, placeHolderText: "Name")
                            .focused($focusedTennantField, equals: .name)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $data.address, placeHolderText: "Address")
                            .focused($focusedTennantField, equals: .address)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $data.address, placeHolderText: "Reference")
                            .focused($focusedTennantField, equals: .reference)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        CustomTextField(text: $data.address, placeHolderText: "ID Number")
                            .focused($focusedTennantField, equals: .tennantID)
                            .onSubmit { self.focusNextField($focusedTennantField) }
                        
                        if showErrorMessage {
                            HStack {
                                ErrorMessageView(errorMessage: ErrorMessage.tenantIDError.rawValue)
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


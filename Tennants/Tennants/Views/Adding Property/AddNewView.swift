import SwiftUI

struct AddNewView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    @Binding var data: NewDataModel
    @State var path: NavigationPath
    @State var showErrorMessage: Bool
    @State var showTennantView: Bool
    
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         path: NavigationPath = NavigationPath(),
         action: @escaping () -> Void) {
        self._data = data
        _path = State(wrappedValue: path)
        _showErrorMessage = State(initialValue: false)
        _showTennantView = State(initialValue: false)
        self.action = action
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
                                .focused($focusedField, equals: .name)
                                .onSubmit { self.focusNextField($focusedField) }
                            
                            CustomTextField(text: $data.address, placeHolderText: "Address")
                                .focused($focusedField, equals: .address)
                                .onSubmit { self.focusNextField($focusedField) }
                            
                            
                            TextField("Number of Units", text: $data.numberOfUnits)
                                .numberTextField()
                            
                            CustomValidatedNumberField(text: $data.numberOfUnitsOccupied,
                                                       placeHolderText: "Number of Units Occupied",
                                                       numberOfUnits: data.numberOfUnits, isProperty: true)
                            
                            if showErrorMessage {
                                ErrorMessageView(errorMessage: ErrorMessage.numberOfUnitsError)
                            }
                            
                            Button {
                                if !validate() {
                                    showErrorMessage = true
                                } else {
                                    action()
                                    showTennantView = true
                                }
                            } label: {
                                Text("Add property")
                                    .padding()
                            }
                            .customHorizontalPadding(isButton: true)
                            //            .disabled(viewModel.amountAdded == "")
                            Spacer()
                            
                        }
                        .navigationTitle("Add a Property")
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Cancel") {
                                    dismiss()
                                }
                            }
                        }
                        .navigationDestination(isPresented: $showTennantView) {
                            AddTenantView(data: $data, path: $path) {
                                action()
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
    AddNewView(data: .constant(NewDataModel()), action: {})
}

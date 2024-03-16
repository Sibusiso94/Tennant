import SwiftUI

struct AddNewView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    @Binding var data: NewDataModel
    
    @State var showErrorMessage: Bool
    @State var showSheet: Bool
    @State var isPropertyAdded: Bool
    
    var propertyOptions: PropertyOptions
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         propertyOptions: PropertyOptions,
         action: @escaping () -> Void) {
        self._data = data
        self.propertyOptions = propertyOptions
        self.action = action
        _showErrorMessage = State(initialValue: false)
        _isPropertyAdded = State(initialValue: false)
        _showSheet = State(initialValue: false)
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
                            
                            switch propertyOptions {
                            case .multipleUnits:
                                TextField("Number of Units", text: $data.numberOfUnits)
                                    .numberTextField()
                                
                                CustomValidatedNumberField(text: $data.numberOfUnitsOccupied,
                                                           placeHolderText: "Number of Units Occupied",
                                                           numberOfUnits: data.numberOfUnits, isProperty: true)
                                
                                if isPropertyAdded {
                                    Button {
                                        action()
                                        
                                    } label: {
                                        Text("Add tenants to property")
                                            .padding()
                                    }
                                    .customHorizontalPadding(isButton: true)
                                    //            .disabled(viewModel.amountAdded == "")
                                } else {
                                    Button {
                                        if !validate() {
                                            showErrorMessage = true
                                        } else {
                                            showSheet = true
                                            isPropertyAdded = true
                                        }
                                    } label: {
                                        Text("Add property")
                                            .padding()
                                    }
                                    .customHorizontalPadding(isButton: true)
                                }
                            case .singleUnit:
                                CustomTextField(text: $data.address, placeHolderText: "Number Of Bedrooms")
                                CustomTextField(text: $data.address, placeHolderText: "Number of Bathrooms")
                                
                                Button {
                                    action()
                                    
                                } label: {
                                    Text("Add property")
                                        .padding()
                                }
                                .customHorizontalPadding(isButton: true)
                                //            .disabled(viewModel.amountAdded == "")
                            }
                            
                            if showErrorMessage {
                                ErrorMessageView(errorMessage: ErrorMessage.numberOfUnitsError)
                            }
                            
                            Spacer()
                            
                        }
                        .navigationTitle("Add a Property")
                    }
                }
            }
            .foregroundStyle(.black)
            .sheet(isPresented: $showSheet, content: {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
            })
        }
    }
}

#Preview {
    AddNewView(data: .constant(NewDataModel()), propertyOptions: .multipleUnits, action: {})
}

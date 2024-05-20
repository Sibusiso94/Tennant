import SwiftUI
import MyLibrary

struct AddPropertyView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    @Binding var data: NewDataModel
    
    @State var showErrorMessage: Bool
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
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        CustomTextField(text: $data.name, placeHolderText: "Name")
                            .focused($focusedField, equals: .name)
                            .onSubmit { self.focusNextField($focusedField) }
                        
                        CustomTextField(text: $data.address,
                                        placeHolderText: "Address",
                                        texFieldHeight: 100,
                                        axis: .vertical)
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
                                    isPropertyAdded = true
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
                        
                        Spacer()
                    }
                    .navigationTitle("Add a Property")
                }
            }
        }
    }
}

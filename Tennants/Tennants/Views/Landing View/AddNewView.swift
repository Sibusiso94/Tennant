import SwiftUI

struct AddNewView: View {
    @FocusState var isInputActive: Bool
    @Environment(\.dismiss) var dismiss
    @Binding var data: NewDataModel
    @State var text: String = ""
    
    var isAProperty: Bool
    var isOnboarding: Bool
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         isAProperty: Bool,
         isOnboarding: Bool = false,
         action: @escaping () -> Void) {
        self._data = data
        self.isAProperty = isAProperty
        self.isOnboarding = isOnboarding
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 25) {
                        TextField("Name", text: $data.name)
                            .padding()
                            .customHorizontalPadding(isButton: false)
                        
                        TextField("Address", text: $data.address)
                            .padding()
                            .customHorizontalPadding(isButton: false)
//                            .focused($isInputActive)
//                            .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                    Spacer()
//                                    
//                                    Button("Done") {
//                                        isInputActive = false
//                                    }
//                                }
//                            }
                        
                        if isAProperty {
                            TextField("Number of Units", text: $data.numberOfUnits)
                                .numberTextField()
                                .focused($isInputActive)
//                                .toolbar {
//                                    ToolbarItemGroup(placement: .keyboard) {
//                                        Spacer()
//                                        
//                                        Button("Done") {
//                                            isInputActive = false
//                                        }
//                                    }
//                                }
                            
                            TextField("Number of Units Occupied", text: $data.numberOfUnitsOccupied)
                                .numberTextField()
                                .focused($isInputActive)
//                                .toolbar {
//                                    ToolbarItemGroup(placement: .keyboard) {
//                                        Spacer()
//                                        
//                                        Button("Done") {
//                                            isInputActive = false
//                                        }
//                                    }
//                                }
                        } else {
                            HStack(spacing: 0) {
                                CustomTextField(text: $data.buildingNumber, placeHolderText: "Building Number")
                                CustomTextField(text: $data.flatNumber, placeHolderText: "Flat Number")
                            }
                            
                            CustomTextField(text: $data.tennantID, placeHolderText: "ID Number")
                            CustomTextField(text: $data.company, placeHolderText: "Company")
                            CustomTextField(text: $data.position, placeHolderText: "Position")
                            CustomTextField(text: $data.monthlyIncome, placeHolderText: "Monthly Income")
                        }
                        
                        Button {
                            data.isAProperty = isAProperty
                            action()
                            dismiss()
                        } label: {
                            Text(isAProperty ? "Add property" : "Add Tennant")
                                .padding()
                        }
                        .customHorizontalPadding(isButton: true)
                        //            .disabled(viewModel.amountAdded == "")
                        Spacer()
                        
                    }
                    .navigationTitle(isAProperty ? "Add a Property" : "Add a Tennant")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if !isOnboarding {
                                Button("Cancel") {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewView(data: .constant(NewDataModel()), isAProperty: true, action: {})
}

struct CustomTextField: View {
    @FocusState var isInputActive: Bool
    @Binding var text: String
    var placeHolderText: String
    
    var body: some View {
        TextField(placeHolderText, text: $text)
            .padding()
            .customHorizontalPadding(isButton: false)
            .focused($isInputActive)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
    }
}

import SwiftUI

struct AddNewView: View {
    @FocusState var isInputActive: Bool
    @Environment(\.dismiss) var dismiss
    @Binding var data: NewDataModel
    @State var text: String = ""
    
    var isAProperty: Bool
    var action: () -> Void
    
    init(data: Binding<NewDataModel>,
         isAProperty: Bool,
         action: @escaping () -> Void) {
        self._data = data
        self.isAProperty = isAProperty
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Cancel")
                    Spacer()
                }
                .padding()
                .onTapGesture {
                    dismiss()
                }
                
                VStack(spacing: 25) {
                    HStack {
                        Text(isAProperty ? "Add a Property" : "Add a Tennant")
                            .font(.title)
                            .bold()
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    TextField("Name", text: $data.name)
                        .padding()
                        .customHorizontalPadding(isButton: false)
                    
                    TextField("Address", text: $data.address)
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
                    
                    if isAProperty {
                        TextField("Number of Units", text: $data.numberOfUnits)
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
                        
                        TextField("Number of Units Occupied", text: $data.numberOfUnitsOccupied)
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
                    } else {
                        HStack {
                            CustomTextField(text: $data.buildingNumber, placeHolderText: "Building Number")
                            CustomTextField(text: $data.flatNumber, placeHolderText: "Flat Number")
                        }
                    }
                    
                    CustomTextField(text: $data.company, placeHolderText: "Company")
                    CustomTextField(text: $data.position, placeHolderText: "Position")
                    CustomTextField(text: $data.monthlyIncome, placeHolderText: "Monthly Income")
                    
                    Button {
                        data.isAProperty = isAProperty
                        action()
                    } label: {
                        Text(isAProperty ? "Add property" : "Add Tennant")
                            .padding()
                    }
                    .customHorizontalPadding(isButton: true)
                    //            .disabled(viewModel.amountAdded == "")
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    AddNewView(data: .constant(NewDataModel()), isAProperty: false, action: {})
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

struct NewDataModel {
    var isAProperty: Bool
    var name: String
    var surname: String
    var address: String
    var numberOfUnits: String
    var numberOfUnitsOccupied: String
    var buildingNumber: String
    var flatNumber: String
    var company: String
    var position: String
    var monthlyIncome: String 
    
    init(isAProperty: Bool = false,
        name: String = "",
         surname: String = "",
        address: String = "",
        numberOfUnits: String = "",
        numberOfUnitsOccupied: String = "",
        buildingNumber: String = "",
        flatNumber: String = "",
        company: String = "",
        position: String = "",
        monthlyIncome: String = "") {
        self.isAProperty = isAProperty
        self.name = name
        self.surname = surname
        self.address = address
        self.numberOfUnits = numberOfUnits
        self.numberOfUnitsOccupied = numberOfUnitsOccupied
        self.buildingNumber = buildingNumber
        self.flatNumber = flatNumber
        self.company = company
        self.position = position
        self.monthlyIncome = monthlyIncome
    }
}

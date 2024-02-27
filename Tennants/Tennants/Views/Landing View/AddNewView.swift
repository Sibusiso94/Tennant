import SwiftUI

struct AddNewView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @FocusState private var focusedTennantField: TennantField?
    
    @Environment(\.dismiss) var dismiss
    @Binding var data: NewDataModel
    @State var showErrorMessage: Bool = false
    
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
                    TextFormView { validate in
                        VStack(spacing: 25) {
                            CustomTextField(text: $data.name, placeHolderText: "Name")
                                .focused($focusedField, equals: .name)
                                .onSubmit { self.focusNextField($focusedField) }
                            
                            CustomTextField(text: $data.address, placeHolderText: "Address")
                                .focused($focusedField, equals: .address)
                                .onSubmit { self.focusNextField($focusedField) }
                            
                            if isAProperty {
                                TextField("Number of Units", text: $data.numberOfUnits)
                                    .numberTextField()
                                
                                CustomValidatedNumberField(text: $data.numberOfUnitsOccupied,
                                                         placeHolderText: "Number of Units Occupied",
                                                         numberOfUnits: data.numberOfUnits)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                                
                                if showErrorMessage {
                                    HStack {
                                        Image(systemName: "exclamationmark.circle")
                                        Text("The number of flats occupied cannot exceed the number of units")
                                    }
                                    .foregroundStyle(.pink)
                                    .opacity(0.4)
                                    .padding(.horizontal)
                                }
                            } else {
                                HStack(spacing: 0) {
                                    CustomTextField(text: $data.buildingNumber, placeHolderText: "Building Number")
                                    CustomTextField(text: $data.flatNumber, placeHolderText: "Flat Number")
                                }
                                
                                CustomValidatedNumberField(text: $data.tennantID,
                                                         placeHolderText: "ID Number",
                                                         numberOfUnits: data.numberOfUnits)
                                .validate({
                                    if data.tennantID == "1234" {
                                        print("WOrking!!!!!!!!!")
                                        return true
                                    } else {
                                        return false
                                    }
                                })
                                    .focused($focusedTennantField, equals: .tennantID)
                                    .onSubmit {
                                        if !validate() {
                                            print("Validated!!!")
                                        } else {
                                            self.focusNextField($focusedTennantField)
                                        }
                                    }
                                
                                CustomTextField(text: $data.company, placeHolderText: "Company")
                                    .focused($focusedTennantField, equals: .company)
                                    .onSubmit { self.focusNextField($focusedTennantField) }
                                
                                CustomTextField(text: $data.position, placeHolderText: "Position")
                                    .focused($focusedTennantField, equals: .position)
                                    .onSubmit { self.focusNextField($focusedTennantField) }
                                
                                CustomTextField(text: $data.monthlyIncome, placeHolderText: "Monthly Income")
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            
                                            Button("Done") {
                                                isInputActive = false
                                            }
                                        }
                                    }
                                    .focused($focusedTennantField, equals: .monthlyIncome)
                                    .onSubmit { self.focusNextField($focusedTennantField) }
                            }
                            
                            Button {
                                data.isAProperty = isAProperty
                                if !validate() {
                                    showErrorMessage = true
                                } else {
                                    action()
                                    dismiss()
                                }
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
}

#Preview {
    AddNewView(data: .constant(NewDataModel()), isAProperty: false, action: {})
}

struct CustomTextField: View {
    @Binding var text: String
    var placeHolderText: String
    
    var body: some View {
        TextField(placeHolderText, text: $text)
            .padding()
            .customHorizontalPadding(isButton: false)
    }
}

struct CustomValidatedNumberField: View {
    @Binding var text: String
    var placeHolderText: String
    var numberOfUnits: String
    
    var body: some View {
        TextField(placeHolderText, text: $text)
            .validate({
                checkIfNumberOfUnitsIsHigherThanOccupied()
            })
            .keyboardType(.numberPad)
            .padding()
            .customHorizontalPadding(isButton: false)
            .foregroundStyle(.black)
    }
    
    func checkIfNumberOfUnitsIsHigherThanOccupied() -> Bool {
        var isHigher = false
        
        if let numberOfUnits = Int(numberOfUnits), let text = Int(text) {
            if numberOfUnits > text {
                isHigher = true
            } else {
                isHigher = false
            }
        }
        
        return isHigher
    }
}

import SwiftUI

struct AddNewTennanView: View {
    @FocusState var isInputActive: Bool
    @State var propertyName: String = ""
    @State var buildingAddress: String = ""
    @State var numberOfUnits: String = ""
    @State var numberOfUnitsOccupied: String = ""
    
    init() {
        _propertyName = State(initialValue: propertyName)
        _buildingAddress = State(initialValue: buildingAddress)
        _numberOfUnits = State(initialValue: numberOfUnits)
        _numberOfUnitsOccupied = State(initialValue: numberOfUnitsOccupied)
    }
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Text("Add a Property")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                Spacer()
            }
            
            TextField("Property name", text: $propertyName)
                .padding()
                .customHorizontalPadding(isButton: false)
            
            TextField("Property Address", text: $buildingAddress)
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
            
            TextField(" Number of Units", text: $numberOfUnits)
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
            
            TextField(" Number of Units Occupied", text: $numberOfUnitsOccupied)
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
            
            Button {
                
            } label: {
                Text("Add property")
                    .padding()
            }
            .customHorizontalPadding(isButton: true)
//            .disabled(viewModel.amountAdded == "")
            Spacer()
           
        }
        .background {
            Color("PastelGrey")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    AddNewTennanView()
}

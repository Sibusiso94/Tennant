import SwiftUI

struct CustomValidatedNumberField: View {
    @Binding var text: String
    var placeHolderText: String
    var numberOfUnits: String
    var isProperty: Bool
    
    init(text: Binding<String>, 
         placeHolderText: String,
         numberOfUnits: String = "",
         isProperty: Bool) {
        self._text = text
        self.placeHolderText = placeHolderText
        self.numberOfUnits = numberOfUnits
        self.isProperty = isProperty
    }
    
    var body: some View {
        TextField(placeHolderText, text: $text)
            .validate({
                if isProperty {
                    checkIfNumberOfUnitsIsHigherThanOccupied()
                } else {
                    checkIDNumber()
                }
            })
            .keyboardType(.numberPad)
            .padding()
            .customHorizontalPadding(isButton: false)
            .foregroundStyle(.black)
    }
    
    func checkIfNumberOfUnitsIsHigherThanOccupied() -> Bool {
        var isHigher = false
        
        if let numberOfUnits = Int(numberOfUnits), let text = Int(text) {
            if numberOfUnits >= text {
                isHigher = true
            } else {
                isHigher = false
            }
        }
        
        return isHigher
    }
    
    func checkIDNumber() -> Bool {
        if text.count == 13 {
            return true
        } else {
            return false
        }
    }
}


#Preview {
    CustomValidatedNumberField(text: .constant(""),
                               placeHolderText: "Placeholder",
                               numberOfUnits: "0",
                               isProperty: false)
}

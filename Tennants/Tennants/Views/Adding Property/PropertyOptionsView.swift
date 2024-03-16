import SwiftUI

enum PropertyOptions {
    case multipleUnits
    case singleUnit
}

struct PropertyOptionsView: View, PropertyTypeOptionable {
    @Binding var propertyType: PropertyOptions
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Select your Property Type")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                OptionCardView(image: Image("image0"), title: "A Property with multiple Units")
                    .onTapGesture {
                        propertyType = .multipleUnits
                        action()
                    }
                
                OptionCardView(image: Image("singleUnit"), title: "A Single Unit")
                    .onTapGesture {
                        propertyType = .singleUnit
                        action()
                    }
            }
            .padding()
        }
    }
}

#Preview {
    PropertyOptionsView(propertyType: .constant(PropertyOptions.multipleUnits), action: {})
}

import SwiftUI

struct CardView: View {
    var property: Property
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            Text(property.buildingName)
                .foregroundStyle(Color.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height / 2.5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

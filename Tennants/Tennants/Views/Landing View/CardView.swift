import SwiftUI

struct CardView: View {
    var property: Property
    var image: Image
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            image
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(property.buildingName)
                .foregroundStyle(Color.black)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height / 2.5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

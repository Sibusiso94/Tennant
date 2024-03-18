import SwiftUI

struct CustomSwipeButton: View {
    var image: Image
    var size: CGFloat
    var backgroundColour: Color
    var action: () -> Void
    
    init(image: Image,
         size: CGFloat = 15,
         backgroundColour: Color = Color.gray.opacity(0.5),
         action: @escaping () -> Void) {
        self.image = image
        self.action = action
        self.size = size
        self.backgroundColour = backgroundColour
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            image
                .font(.system(size: size, weight: .bold))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .padding(13)
                .background(backgroundColour)
                .clipShape(Circle())
        }
    }
}

#Preview {
    CustomSwipeButton(image: Image("image0"), action: {})
}

import SwiftUI

struct OptionCardView: View {
    var image: Image
    var title: String
    var width: CGFloat
    var height: CGFloat
    
    init(image: Image,
         title: String,
         width: CGFloat = 150,
         height: CGFloat = 150) {
        self.image = image
        self.title = title
        self.width = width
        self.height = height
    }
    
    var body: some View {
        VStack(alignment: .center) {
            image
                .resizable()
                .frame(width: width, height: height)
                .padding()
            
            Text(title)
                .foregroundStyle(Color.black)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    OptionCardView(image: Image("image0"), title: "")
}

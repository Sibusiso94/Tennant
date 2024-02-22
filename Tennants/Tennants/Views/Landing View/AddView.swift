import SwiftUI

struct AddView: View {
    @Binding var shouldShowAddProperty: Bool
    var title: String?
    var width: CGFloat
    var height: CGFloat
    
    init(shouldShowAddProperty: Binding<Bool>,
         title: String? = nil,
         width: CGFloat,
         height: CGFloat) {
        _shouldShowAddProperty = shouldShowAddProperty
        self.title = title
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
            
            VStack(spacing: 30) {
                Spacer()
                if let title = title {
                    Text(title)
                        .font(.title)
                        .bold()
                }
                
                Image("EmptyViewImage")
                    .resizable()
                    .frame(width: width, height: height)
                
                Button {
                    shouldShowAddProperty = true
                } label: {
                    Text("Add Property")
                        .padding()
                }
                .customHorizontalPadding(isButton: true)
                
                Spacer()
            }
        }
    }
}

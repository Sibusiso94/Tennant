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
            
            VStack {
                Spacer()
                if let title = title {
                    Text(title)
                        .font(.title)
                }
                
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundStyle(Color("DarkPastelBlue"))
                    .onTapGesture {
                        shouldShowAddProperty = true
                    }
                
                Spacer()
            }
        }
    }
}

import SwiftUI

struct AddView: View {
    @Binding var shouldShowAddProperty: Bool
    var title: String?
    var width: CGFloat
    var height: CGFloat
    var isNoData: Bool
    
    init(shouldShowAddProperty: Binding<Bool>,
         title: String? = nil,
         width: CGFloat,
         height: CGFloat,
         isNoData: Bool) {
        _shouldShowAddProperty = shouldShowAddProperty
        self.title = title
        self.width = width
        self.height = height
        self.isNoData = isNoData
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
            
            if isNoData {
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
            } else {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundStyle(Color("DarkPastelBlue"))
                    .onTapGesture {
                        shouldShowAddProperty = true
                    }
            }
        }
    }
}

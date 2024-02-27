import SwiftUI

struct CustomButtonHorizontalAlignment: ViewModifier {
    var isButton: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background {
                isButton ? Color("DarkPastelBlue") : Color.white
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
    }
}

extension View {
    func customHorizontalPadding(isButton: Bool) -> some View {
        modifier(CustomButtonHorizontalAlignment(isButton: isButton))
    }
}

import SwiftUI

struct CustomButtonHorizontalAlignment: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background {
                Color.white
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
    }
}

extension View {
    func buttonHorizontalPadding() -> some View {
        modifier(CustomButtonHorizontalAlignment())
    }
}

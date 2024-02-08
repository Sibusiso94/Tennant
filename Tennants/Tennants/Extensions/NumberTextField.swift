import SwiftUI

struct NumberTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 50)
            .customHorizontalPadding(isButton: false)
            .padding(.top)
            .keyboardType(.numberPad)
            .foregroundStyle(Color.black)
    }
}

extension View {
    func numberTextField() -> some View {
        modifier(NumberTextField())
    }
}

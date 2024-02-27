import SwiftUI

struct NumberTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .customHorizontalPadding(isButton: false)
            .keyboardType(.numberPad)
            .foregroundStyle(Color.black)
    }
}

extension View {
    func numberTextField() -> some View {
        modifier(NumberTextField())
    }
}

import SwiftUI

struct CustomBackgroundColour: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("PastelGrey"))
            .ignoresSafeArea()
    }
}

extension View {
    func backgroundColour() -> some View {
        modifier(CustomBackgroundColour())
    }
}

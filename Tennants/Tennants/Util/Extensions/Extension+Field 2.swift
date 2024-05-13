import SwiftUI

extension View {
    func validate(_ flag: @escaping () -> Bool) -> some View {
        self
            .modifier(ValidationModifier(validation: flag))
    }
}

extension TextField {
    func validate(_ flag: @escaping () -> Bool) -> some View {
        self
            .modifier(ValidationModifier(validation: flag))
    }
}

extension SecureField {
    func validate(_ flag: @escaping () -> Bool) -> some View {
        self
            .modifier(ValidationModifier(validation: flag))
    }
}

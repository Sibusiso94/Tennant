import Foundation
import SwiftUI

struct ValidationModifier: ViewModifier {
    let validation: () -> Bool
    
    func body(content: Content) -> some View {
        content
            .preference(
                key: ValidationPreferenceKey.self,
                value: [validation()]
            )
    }
}

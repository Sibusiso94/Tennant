import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeHolderText: String
    
    var body: some View {
        TextField(placeHolderText, text: $text)
            .padding()
            .customHorizontalPadding(isButton: false)
    }
}

#Preview {
    CustomTextField(text: .constant(""), placeHolderText: ":)")
}

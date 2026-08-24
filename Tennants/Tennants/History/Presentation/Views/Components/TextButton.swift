import SwiftUI

public struct TextButton: View {
    var title: String
    var action: () -> Void

    public init(title: String,
                action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(Color.black.opacity(0.6))
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("DarkPastelBlue"))
        .foregroundStyle(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

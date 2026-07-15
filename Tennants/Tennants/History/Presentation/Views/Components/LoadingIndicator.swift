import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        VStack {
            ProgressView("Loading…")
                .padding()
        }
        .bannerBorder(cornerRadius: 15)
    }
}

#Preview {
    LoadingIndicator()
}

extension View {
    func bannerBorder(cornerRadius: CGFloat = 25) -> some View {
        background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .accessibilityHidden(true)
        }
    }
}

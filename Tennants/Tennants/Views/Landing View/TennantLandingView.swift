import SwiftUI

struct TennantLandingView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Spacer()
            GeometryReader { geometry in
                LazyVGrid(columns: columns) {
                    ForEach(0..<4) { item in
                        Text("Placeholder")
                            .frame(maxWidth: .infinity)
                            .frame(height: geometry.size.height / 2.5)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TennantLandingView()
}

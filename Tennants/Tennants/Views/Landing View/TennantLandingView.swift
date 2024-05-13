import SwiftUI
import MyLibrary

struct TennantLandingView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 80)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns) {
                        ForEach(0..<4) { item in
                            PlaceholderView(geometry: geometry)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background {
                Color("PastelGrey")
                    .ignoresSafeArea()
            }
        }
    }
}

struct PlaceholderView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Placeholder")
                .foregroundStyle(Color.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: geometry.size.height / 2.5)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    TennantLandingView()
}

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let percentageString: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            Text(percentageString)
                .font(.title)
                .bold()
        }
        .padding(.vertical)
    }
}

#Preview {
    CircularProgressView(progress: 0.8, percentageString: "80%")
}

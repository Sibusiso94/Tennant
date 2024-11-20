import SwiftUI

struct OnboardingSubView: View {
    let onboardingItem: OnboardingItem

    var body: some View {
        VStack {
            Text(onboardingItem.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Image(onboardingItem.image)
                .resizable()
                .frame(width: 250, height: 250)

            Text(onboardingItem.subTitle)
                    .multilineTextAlignment(.center)
                    .padding()
        }
        .backgroundColour()
    }
}

#Preview {
    OnboardingSubView(onboardingItem: OnboardingItem(title: "", image: "", subTitle: ""))
}

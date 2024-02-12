import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let subTitle: String
}

final class OnboardingManager: ObservableObject {
    @Published private(set) var items: [OnboardingItem] = []
    
    func load() {
        items = [
            .init(title: "Welcome, let's get you started", 
                  image: "First",
                  subTitle: ""),
            .init(title: "How many properties do you own?",
                  image: "Second",
                  subTitle: "Please select the number of properties you own and the number of units en each property.")
        ]
    }
}

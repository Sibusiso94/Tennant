import Foundation

enum CurrentPage {
    case first
    case second
    case third
}

struct OnboardingItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let image: String
    let subTitle: String
}

final class OnboardingManager: ObservableObject {
    @Published private(set) var items: [OnboardingItem] = []

    init() {
        load()
    }

    func load() {
        items = [
            .init(title: "Welcome, let's get you started",
                  image: "image0",
                  subTitle: ""),
            .init(title: "Setting up your properties",
                  image: "First",
                  subTitle: "You'll start by setting up your property and then edit the details to set up tennants")
        ]
    }
}

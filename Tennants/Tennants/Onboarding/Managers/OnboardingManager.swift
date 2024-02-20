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
                  image: "First",
                  subTitle: ""),
            .init(title: "Setting up your properties",
                  image: "Second",
                  subTitle: "You'll start by setting up your proprty and then edit the details to set up tennants")
        ]
    }
}

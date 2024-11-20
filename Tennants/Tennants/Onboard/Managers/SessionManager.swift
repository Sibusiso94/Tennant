import Foundation

class SessionManager: ObservableObject {
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }

    enum CurrentState {
        case onboarding
        case homeView
    }

    @Published private(set) var currentState: CurrentState?

    init() {
        configureCurrentState()
    }

    func completeOnboarding() {
        currentState = .homeView
        UserDefaults.standard.set(true, forKey:  UserDefaultKeys.hasSeenOnboarding)
    }

    func configureCurrentState() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        currentState = hasCompletedOnboarding ? .homeView : .onboarding
    }
}



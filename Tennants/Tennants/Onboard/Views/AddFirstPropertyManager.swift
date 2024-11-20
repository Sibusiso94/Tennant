import Foundation

class AddFirstPropertyManager: ObservableObject {
    enum Screen: Int, CaseIterable {
        case firstProperty
        case firstTennant
    }
    
    @Published var active: Screen = Screen.allCases.first!
    
    func next() {
        let nextScreenIndex = min(active.rawValue + 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: nextScreenIndex) {
            active = screen
        }
    }
    
    func previous() {
        let previousScreenIndex = max(active.rawValue - 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: previousScreenIndex) {
            active = screen
        }
    }
}

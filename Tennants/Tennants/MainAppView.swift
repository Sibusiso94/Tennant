import SwiftUI

struct MainAppView: View {
    @StateObject private var session: SessionManager
    private let factory = AppFactory()

    init() {
        _session = StateObject(wrappedValue: SessionManager())
    }
    
    var body: some View {
        ZStack {
            switch session.currentState {
            case .onboarding:
                OnboardingView(action: session.completeOnboarding)
                .transition(.opacity)
            case .homeView:
                factory.makeMainTabView()
                    .transition(.opacity)
            default:
                // Splash Screen
                Color.gray.ignoresSafeArea()
            }
        }
        .animation(.easeInOut, value: session.currentState)
    }
}

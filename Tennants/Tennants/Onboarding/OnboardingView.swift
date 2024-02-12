import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
//    @State var navigationPath = NavigationPath()
    
    init() {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel())
//        _navigationPath = State(initialValue: NavigationPath())
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey").ignoresSafeArea()
            
            TabView {
                OnboardingSubView(input: $viewModel.input,
                                  title: "Welcome, let's get you started",
                                  image: "First")
                
                OnboardingSubView(input: $viewModel.input,
                                  title: "How many properties do you own?",
                                  image: "Second")
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    OnboardingView()
}

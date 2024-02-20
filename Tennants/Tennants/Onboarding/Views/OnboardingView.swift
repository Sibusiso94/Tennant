import SwiftUI

struct OnboardingView: View {
    @StateObject private var manager: OnboardingManager
    @State private var showButton: Bool
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        _manager = StateObject(wrappedValue: OnboardingManager())
        _showButton = State(initialValue: false)
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey").ignoresSafeArea()
            
            if !manager.items.isEmpty {
                TabView {
                    ForEach(manager.items) { item in
                        OnboardingSubView(onboardingItem: item)
                            .onAppear {
                                if item == manager.items.last {
                                    showButton = true
                                } else {
                                    showButton = false
                                }
                            }
                            .overlay(alignment: .bottom) {
                                if showButton == true {
                                    Button {
                                        action()
                                    } label: {
                                        Text("Continue")
                                            .padding()
                                    }
                                    .customHorizontalPadding(isButton: true)
                                    .offset(y: 50)
                                    .transition(.scale.combined(with: .opacity))
                                }
                            }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
}

#Preview {
    OnboardingView(action: {})
}

import SwiftUI

struct BottomNavigation: View {
    @ObservedObject var viewModel: SwipeActionViewModel
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            CustomSwipeButton(image: Image(systemName: "heart.fill"), size: 18, backgroundColour: .red.opacity(0.5)) {
                doSwipe()
                action()
            }
        }
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingUnits.first else { return }
        
        // Using Notification to post and receive in Stack Cards
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.UnitNumber,
            "rightSwipe": rightSwipe
        ])
    }
}


#Preview {
    BottomNavigation(viewModel: SwipeActionViewModel(), action: {})
}

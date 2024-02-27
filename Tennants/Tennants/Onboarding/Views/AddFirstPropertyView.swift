import SwiftUI

struct AddFirstPropertyView: View {
    @ObservedObject var landingViewModel: LandingViewModel
    @StateObject var manager: AddFirstPropertyManager
    
    init(landingViewModel: LandingViewModel) {
        self.landingViewModel = landingViewModel
        _manager = StateObject(wrappedValue: AddFirstPropertyManager())
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
//            TabView(selection: $manager.active) {
//                AddNewView(data: $landingViewModel.newData,
//                           isAProperty: true,
//                           isOnboarding: true,
//                           action: manager.next)
//                .tag(AddFirstPropertyManager.Screen.firstProperty)
//                
//                AddNewView(data: $landingViewModel.newData,
//                           isAProperty: false,
//                           isOnboarding: true) {
//                    landingViewModel.addData()
//                }
//                           .tag(AddFirstPropertyManager.Screen.firstTennant)
//            }
//            .animation(.easeInOut, value: manager.active)
//            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    AddFirstPropertyView(landingViewModel: LandingViewModel())
}

import SwiftUI

struct StackCardView: View {
    @EnvironmentObject var viewModel: SwipeActionViewModel
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = 0
    @State var endSwipe: Bool = false
    
    var unit: SingleUnit
    
    init(unit: SingleUnit) {
        self.unit = unit
    }
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(viewModel.getIndex(of: unit))
            let topOffSet = (index <= 2 ? index : 2) * 15
            
            ZStack {
                Color(.white)
                
//                Text("There are no more flats available")
//                    .foregroundStyle(.gray.opacity(0.5))
                
                VStack {
                    Image("image0")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("Unit number: \(unit.UnitNumber)")
                    Text("Building ID: \(unit.buildingID)")
                    Text("Tennant ID: \(unit.tennantID)")
                    Text("Bedrooms: \(unit.numberOfBedrooms)")
                    Text("Bathrooms: \(unit.numberOfBathrooms)")
                    Text("Is it available?: \(unit.isAvailable.description)")
                }
                .foregroundStyle(.black)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("DarkPastelBlue"), lineWidth: 4)
            )
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(y: topOffSet)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let transition = value.translation.width
                    let checkingStatus = (transition > 0 ? transition : -transition)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            // Remove card
                            offset = (transition > 0 ? width : -width) * 2
                            endSwipeActions()
                            
                            if transition > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            guard let info = data.userInfo else { return }
            
            let id = info["id"] as? Int ?? 0
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            
            if unit.UnitNumber == id {
                #warning("Action be made here to update unit")
                withAnimation {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    } else {
                        leftSwipe()
                    }
                }
            }
        }
    }
    
    func getRotation(angle: Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }
    
    func endSwipeActions() {
        withAnimation() {
            endSwipe = true
        }
        
        #warning("need to change to save not remove")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = viewModel.displayingUnits.first {
                let _ = withAnimation {
                    viewModel.displayingUnits.removeFirst()
                }
            }
        }
    }
    
    func rightSwipe() {
        #warning("Do actions here")
        print("Right Swiped")
    }
    
    func leftSwipe() {
        #warning("Do actions here")
        print("Left Swiped")
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

#Preview {
    StackCardView(unit: SingleUnit())
}

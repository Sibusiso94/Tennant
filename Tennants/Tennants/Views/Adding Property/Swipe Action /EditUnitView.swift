import SwiftUI

struct EditUnitView: View {
    @StateObject var viewModel = SwipeActionViewModel()
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            VStack {
                TopNavBar(image: Image(systemName: "menucard"),
                          title: "Discover")
                
                ZStack {
                    ForEach(viewModel.displayingUnits) { unit in
                        StackCardView(unit: unit)
                            .environmentObject(viewModel)
                            .padding()
                    }
                    
                }
                .padding(.vertical)
                
                BottomNavigation() {
                    
                }
            }
        }
    }
}

struct TopNavBar: View {
    var image: Image
    var title: String
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                image
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text(title)
                    .font(.title.bold())
            )
            .foregroundStyle(.black)
            .padding()
        }
    }
}

struct BottomNavigation: View {
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            CustomSwipeButton(image: Image(systemName: "arrow.uturn.backward")) {
                action()
            }
            
            CustomSwipeButton(image: Image(systemName: "xmark"),
                              size: 18,
                              backgroundColour: Color("DarkPastelBlue")) {
                action()
            }
            
            CustomSwipeButton(image: Image(systemName: "star.fill"), backgroundColour: .yellow.opacity(0.5)) {
                action()
            }
            
            CustomSwipeButton(image: Image(systemName: "heart.fill"), size: 18, backgroundColour: .red.opacity(0.5)) {
                action()
            }
        }
    }
}

struct CustomSwipeButton: View {
    var image: Image
    var size: CGFloat
    var backgroundColour: Color
    var action: () -> Void
    
    init(image: Image,
         size: CGFloat = 15,
         backgroundColour: Color = Color.gray.opacity(0.5),
         action: @escaping () -> Void) {
        self.image = image
        self.action = action
        self.size = size
        self.backgroundColour = backgroundColour
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            image
                .font(.system(size: size, weight: .bold))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .padding(13)
                .background(backgroundColour)
                .clipShape(Circle())
        }
    }
}

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
                            endSwipe = true
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
#Preview {
    EditUnitView()
}

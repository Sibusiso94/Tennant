import SwiftUI

struct EditUnitView: View {
    @StateObject var viewModel = SwipeActionViewModel()
    @State var showSecondView = false
    var units: [SingleUnit]
    
    init(units: [SingleUnit]) {
        self.units = units
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
                VStack {
                    ZStack {
                        ForEach(units) { unit in
                            StackCardView(unit: unit)
                                .environmentObject(viewModel)
                                .padding()
                        }
                        
                    }
                    .padding(.vertical)
                    
                    BottomNavigation(viewModel: viewModel) {
                        
                    }
                }
            
        }
    }
}

#Preview {
    EditUnitView(units: [SingleUnit(unitNumber: 1,
                                    buildingID: "Telesto",
                                    numberOfBedrooms: 1,
                                    numberOfBathrooms: 1,
                                    isAvailable: false), SingleUnit(unitNumber: 2,
                                                                    buildingID: "Telesto",
                                                                    numberOfBedrooms: 1,
                                                                    numberOfBathrooms: 1,
                                                                    isAvailable: false), SingleUnit(unitNumber: 3,
                                                                                                    buildingID: "Telesto",
                                                                                                    numberOfBedrooms: 1,
                                                                                                    numberOfBathrooms: 1,
                                                                                                    isAvailable: false)])
}

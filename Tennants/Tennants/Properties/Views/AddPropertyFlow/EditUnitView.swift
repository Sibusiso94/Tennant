import SwiftUI
import MyLibrary

struct EditUnitView: View {
    @State var units = [SingleUnit(unitNumber: 1, property: Property(), numberOfBedrooms: 1, numberOfBathrooms: 1),
                 SingleUnit(unitNumber: 2, property: Property(), numberOfBedrooms: 2, numberOfBathrooms: 2),
                 SingleUnit(unitNumber: 3, property: Property(), numberOfBedrooms: 3, numberOfBathrooms: 3),
                 SingleUnit(unitNumber: 4, property: Property(), numberOfBedrooms: 2, numberOfBathrooms: 2),
                 SingleUnit(unitNumber: 5, property: Property(), numberOfBedrooms: 3, numberOfBathrooms: 2)]
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
//            ForEach(Array(units.enumerated()), id: \.offset) {index, unit in
//                StackCardView(unitNumber: "\(units[index].unitNumber)", numberOfBedrooms: $units[index].numberOfBedrooms, numberOfBathrooms: $units[index].numberOfBathrooms, isAvailable: $units[index].isAvailable)
//                    .frame(height: 300)
//                    .padding(.horizontal)
//            }
        }
    }
}

#Preview {
    EditUnitView()
}

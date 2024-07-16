import SwiftUI
import MyLibrary

struct EditUnitView: View {
    @State var units = [SingleUnit(unitNumber: 1, buildingID: "Y", numberOfBedrooms: 1, numberOfBathrooms: 1, isAvailable: false),
                 SingleUnit(unitNumber: 2, buildingID: "Y", numberOfBedrooms: 2, numberOfBathrooms: 2, isAvailable: false),
                 SingleUnit(unitNumber: 3, buildingID: "Y", numberOfBedrooms: 3, numberOfBathrooms: 3, isAvailable: false),
                 SingleUnit(unitNumber: 4, buildingID: "Y", numberOfBedrooms: 2, numberOfBathrooms: 2, isAvailable: false),
                 SingleUnit(unitNumber: 5, buildingID: "Y", numberOfBedrooms: 3, numberOfBathrooms: 2, isAvailable: false)]
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            
            ForEach(Array(units.enumerated()), id: \.offset) {index, unit in
                StackCardView(unitNumber: "\(units[index].unitNumber)", numberOfBedrooms: $units[index].numberOfBedrooms, numberOfBathrooms: $units[index].numberOfBathrooms, isAvailable: $units[index].isAvailable)
                    .frame(height: 300)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    EditUnitView()
}

import SwiftUI

struct UnitDetailViewContainer: View {
    var unit: SingleUnit
    var complexName: String
    var address: String
    var tenant: Tennant?

    init(unit: SingleUnit,
         complexName: String,
         address: String,
         tenant: Tennant? = nil) {
        self.unit = unit
        self.complexName = complexName
        self.address = address
        self.tenant = tenant
    }
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    UnitDetailView(title: "Room \(unit.unitNumber)",
                                   image: Image("house"),
                                   complexName: complexName,
                                   address: address,
                                   bedrooms: "\(unit.numberOfBedrooms)",
                                   bathrooms: "\(unit.numberOfBathrooms)",
                                   size: "350m")

                    Divider()

                    if let tenant, unit.isOccupied {
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color("PastelBlue"))

                            VStack(alignment: .leading) {
                                Text("\(tenant.name) \(tenant.surname)")
                                Text("\(tenant.position)")
                                    .foregroundStyle(.secondary)
                                Text("Balance: \(tenant.balance)")
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                            VStack {
                                Image(systemName: "ellipsis.message")
                                    .padding()
                            }
                            .background(Color("PastelLightBlue"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding()
                    }

                    Divider()
                }
            }
        }
    }
}

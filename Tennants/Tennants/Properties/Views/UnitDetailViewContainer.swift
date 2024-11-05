import SwiftUI
import MyLibrary

struct UnitDetailViewContainer: View {
    @State var showAddTenantView = false
    @ObservedObject var viewModel: PropertyDetailViewModel

    var unit: SingleUnit
    var complexName: String
    var buildingId: String
    var address: String
    var tenant: Tennant?

    init(viewModel: PropertyDetailViewModel,
         unit: SingleUnit,
         complexName: String,
         buildingId: String,
         address: String,
         tenant: Tennant? = nil) {
        self.viewModel = viewModel
        self.unit = unit
        self.complexName = complexName
        self.buildingId = buildingId
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
                                   size: "\(unit.size)m")

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
                    } else {
                        VStack {
                            Text("This unit is not occupied. Add a tenant below.")
                                .multilineTextAlignment(.center)
                            CustomTextButton(title: "Add tenant") {
                                showAddTenantView = true
                            }
                        }
                        .padding()
                    }

                    Divider()
                }
            }
        }
        .navigationDestination(isPresented: $showAddTenantView) {
            AddTenantView() { tenant in
                viewModel.addTenant(tenant, propertyID: buildingId, unitId: unit.id)
            }
        }
    }
}

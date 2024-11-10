import SwiftUI
import MyLibrary

struct UnitDetailViewContainer: View {
    @ObservedObject var propertyViewModel: PropertiesViewModel
    @ObservedObject var viewModel: PropertyDetailViewModel
    @State var showAddTenantView = false
    @State var showAlert = false
    @State var showEditingView = false

    var unit: SingleUnit
    var complexName: String
    var buildingId: String
    var address: String
    var tenant: Tennant?

    init(propertyViewModel: PropertiesViewModel,
         viewModel: PropertyDetailViewModel,
         unit: SingleUnit,
         complexName: String,
         buildingId: String,
         address: String,
         tenant: Tennant? = nil) {
        self.propertyViewModel = propertyViewModel
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
                        TenantInfoView(name: tenant.name,
                                       surname: tenant.surname,
                                       position: tenant.position,
                                       startDate: tenant.startDate.formatted(date: .abbreviated, time: .omitted),
                                       endDate: tenant.endDate.formatted(date: .abbreviated, time: .omitted))
                        .padding()
                    } else {
                        EmptyTenantStateView($showAddTenantView)
                        .padding()
                    }

                    Divider()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                CustomMenuButton {
                    propertyViewModel.propertyType = PropertyOptions.singleUnit
                    showEditingView = true
                } option2Action: {
                    showAlert = true
                }

            }
        }
        .navigationDestination(isPresented: $showAddTenantView) {
            AddTenantView() { tenant in
                viewModel.addTenant(tenant, propertyID: buildingId, unitId: unit.id)
            }
        }
        .sheet(isPresented: $showEditingView) {
            AddPropertyView(viewModel: propertyViewModel, isEditing: true) {
                viewModel.updateUnit(id: unit.id,
                                     tenantId: tenant?.id,
                                     beds: Int(propertyViewModel.newData.numberOfBedrooms),
                                     baths: Int(propertyViewModel.newData.numberOfBathrooms),
                                     size: Int(propertyViewModel.newData.size))
            }
        }
        .alert("Are you sure you want to delete?", isPresented: $showAlert) {
            Button("Yes", role: .cancel) {
//                dismiss()
            }

            Button("Cancel", role: .destructive) { }
        }
    }
}

struct TenantInfoView: View {
    let name: String
    let surname: String
    let position: String
    let startDate: String
    let endDate: String

    init(name: String, 
         surname: String,
         position: String,
         startDate: String,
         endDate: String) {
        self.name = name
        self.surname = surname
        self.position = position
        self.startDate = startDate
        self.endDate = endDate
    }

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color("PastelBlue"))

            VStack(alignment: .leading) {
                Text("\(name) \(surname)")
                Text("\(position)")
                    .foregroundStyle(.secondary)

                Text("\(startDate) - \(endDate)")
                    .foregroundStyle(.secondary)
            }

            VStack {
                Image(systemName: "ellipsis.message")
                    .padding()
            }
            .background(Color("PastelLightBlue"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.leading)
        }
    }
}

struct EmptyTenantStateView: View {
    @Binding var showAddTenantView: Bool

    init(_ showAddTenantView: Binding<Bool>) {
        self._showAddTenantView = showAddTenantView
    }

    var body: some View {
        VStack {
            Text("This unit is not occupied. Add a tenant below.")
                .multilineTextAlignment(.center)
            CustomTextButton(title: "Add tenant") {
                showAddTenantView = true
            }
        }
    }
}

import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    var property: Property
    @State var tenants = MockTenants.tenants
    
    init(property: Property) {
        _showDetailView = State(initialValue: false)
        self.property = property
    }
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack {
                            Text(property.buildingAddress)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            Text("  All Units ocupied")
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView {
                        ForEach(tenants) { tenant in
                            UpdateTennantTopCardView(unitNumber: tenant.unitID, 
                                                     name: tenant.name,
                                                     surname: tenant.surname,
                                                     balance: "\(tenant.balance)",
                                                     amountDue: "\(tenant.amountDue)",
                                                     reference: "\(tenant.reference)")
                                .onTapGesture {
                                    selectedTenant = tenant
                                    showDetailView = true
                                }
                                .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle(property.buildingName)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
                .navigationDestination(isPresented: $showDetailView) {
                    withAnimation {
                        UpdateTennantView(tenant: $selectedTenant)
                    }
                }
            }
        }
    }
}

#Preview {
    PropertyDetailView(property: Property(buildingName: "Telesto", buildingAddress: "Pinotage Street"))
}

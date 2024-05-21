import SwiftUI
import MyLibrary

struct TenantsView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    @Binding var tenants: [Tennant]
    var properties: [String]
    
    init(tenants: Binding<[Tennant]>, properties: [String]) {
        _showDetailView = State(initialValue: false)
        self._tenants = tenants
        self.properties = properties
    }
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                ScrollView {
                    ForEach(tenants) { tenant in
                        UpdateTennantTopCardView(unitNumber: tenant.unitID, name: tenant.name, surname: tenant.surname, balance: "\(tenant.balance)", amountDue: "\(tenant.amountDue)")
                            .onTapGesture {
                                selectedTenant = tenant
                                showDetailView = true
                            }
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(properties.first ?? "")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .navigationDestination(isPresented: $showDetailView) {
                UpdateTennantView(tenant: $selectedTenant)
            }
        }
    }
}

#Preview {
    TenantsView(tenants: .constant(MockTenants.tenants), properties: ["Telesto"])
}

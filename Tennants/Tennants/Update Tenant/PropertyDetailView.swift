import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    @State var tenants = MockTenants.tenants
    
    @ObservedObject var viewModel: PropertiesViewModel
    @Environment(\.dismiss) var dismiss
    var property: Property
    
    init(property: Property, viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
        self.property = property
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
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
                                                     amountDue: "\(tenant.amountDue)")
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
                        PropertyMenuButton {
                            print("edit")
                        } deleteAction: {
                            viewModel.manager.deleteProperties(property: property)
                            dismiss()
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

//#Preview {
//    PropertyDetailView(property: Property(buildingName: "Telesto", buildingAddress: "Pinotage Street"), viewModel: <#PropertiesViewModel#>)
//}

struct PropertyMenuButton: View {
    var editAction: () -> Void
    var deleteAction: () -> Void
    
    init(editAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.editAction = editAction
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        Menu {
            Button {
                editAction()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                deleteAction()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
}

import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    @State var tenants = MockTenants.tenants
    
    @ObservedObject var viewModel: PropertiesViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
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
                            Text(viewModel.selectedProperty.buildingAddress)
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
                .navigationTitle(viewModel.selectedProperty.buildingName)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        CustomMenuButton {
                            print("edit")
                        } option2Action: {
                            viewModel.manager.deleteProperty(viewModel.selectedProperty)
                            viewModel.refreshData()
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

struct CustomMenuButton: View {
    var option1Action: () -> Void
    var option2Action: () -> Void
    
    init(option1Action: @escaping () -> Void,
         option2Action: @escaping () -> Void) {
        self.option1Action = option1Action
        self.option2Action = option2Action
    }
    
    var body: some View {
        Menu {
            Button {
                option1Action()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                option2Action()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
}

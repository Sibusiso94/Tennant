import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    
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
                        ForEach(viewModel.selectedProperty.units) { unit in
                            UpdateTennantTopCardView(unitNumber: String(unit.unitNumber),
                                                     name: unit.tenant.name,
                                                     surname: unit.tenant.surname,
                                                     balance: "\(unit.tenant.balance)",
                                                     amountDue: "\(unit.tenant.amountDue)")
                                .onTapGesture {
                                    selectedTenant = unit.tenant
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

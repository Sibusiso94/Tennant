import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    
    @StateObject var detailViewModel: PropertyDetailViewModel
    @ObservedObject var viewModel: PropertiesViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
        self.viewModel = viewModel
        _detailViewModel = StateObject(wrappedValue: PropertyDetailViewModel(viewModel.selectedProperty.units))
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
                        ForEach(detailViewModel.units) { unit in
                            UpdateTennantTopCardView(unitNumber: String(unit.unitNumber),
                                                     name: unit.tenant.name,
                                                     surname: unit.tenant.surname,
                                                     balance: "\(unit.tenant.balance)",
                                                     amountDue: "\(unit.tenant.amountDue)", isOccupied: unit.isOccupied)
                                .onTapGesture {
                                    viewModel.selectedUnit = unit
                                    viewModel.selectedTenant = unit.tenant
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
//                    withAnimation {
                    if viewModel.selectedUnit.isOccupied {
                        UpdateTennantView(tenant: $viewModel.selectedTenant, unit: viewModel.selectedUnit)
                        } else {
                            AddTenantView($viewModel.selectedTenant) {
                                viewModel.addTenant()
                            }
                        }
//                    }
                }
            }
        }
    }
}

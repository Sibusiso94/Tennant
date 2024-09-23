import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var showDetailView: Bool
    @State var showAlert = false
    @StateObject var detailViewModel: PropertyDetailViewModel
    @ObservedObject var viewModel: PropertiesViewModel
    
    init(viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
        self.viewModel = viewModel
        _detailViewModel = StateObject(wrappedValue: PropertyDetailViewModel(viewModel.tenants))
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
                        ForEach(detailViewModel.tenants) { tenant in
                            UpdateTennantTopCardView(unitNumber: String(tenant.unitNumber),
                                                     name: tenant.name,
                                                     surname: tenant.surname,
                                                     balance: String(tenant.balance),
                                                     amountDue: String(tenant.amount),
                                                     isOccupied: tenant.isOccupied)
                                .onTapGesture {
                                    viewModel.selectedUnit.id = tenant.unitId
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
                            showAlert = true
                        }

                    }
                }
                .navigationDestination(isPresented: $showDetailView) {
//                    withAnimation {
                    if viewModel.selectedUnit.isOccupied {
                        UpdateTennantView(tenant: $viewModel.selectedTenant, unit: viewModel.selectedUnit)
                        } else {
                            AddTenantView() { tenant in
                                viewModel.addTenant(tenant)
                            }
                        }
//                    }
                }
                .alert("Are you sure you want to delete?", isPresented: $showAlert) {
                    Button("Yes", role: .cancel) {
                        dismiss()
                        viewModel.delete(viewModel.selectedProperty.buildingID)
                    }
                    
                    Button("Cancel", role: .destructive) { }
                }
            }
        }
    }
}

import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var showDetailView: Bool
    @State var showAddTenantView = false
    @State var showAlert = false
    @State var selectedTenant: Tennant?
    @StateObject var detailViewModel: PropertyDetailViewModel
    @ObservedObject var viewModel: PropertiesViewModel
    
    init(viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
        self.viewModel = viewModel
        _detailViewModel = StateObject(wrappedValue: PropertyDetailViewModel(unitManager: viewModel.manager.unitManager))
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
                                .bold()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView {
                        ForEach(viewModel.unitCardModel) { unitModel in
//                            UpdateTennantTopCardView(unitNumber: String(tenant.unitNumber),
//                                                     name: tenant.name,
//                                                     surname: tenant.surname,
//                                                     balance: String(tenant.balance),
//                                                     amountDue: String(tenant.amount),
//                                                     isOccupied: tenant.isOccupied)
                            UnitTopCardView(imageNumber: String(unitModel.unitNumber),
                                            unitNumber: String(unitModel.unitNumber),
                                            address: viewModel.selectedProperty.buildingAddress,
                                            isOccupied: unitModel.isOccupied)
                                .onTapGesture {
                                    setUpCardDetail(with: unitModel)
                                    detailViewModel.fetchUnit(unitModel.unitId)
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
//                    UpdateTennantView(tenant: selectedTenant, unitNumber: String(viewModel.selectedUnit.unitNumber))
                    UnitDetailViewContainer(unit: detailViewModel.unit,
                                            complexName: viewModel.selectedProperty.buildingName,
                                            address: viewModel.selectedProperty.buildingAddress,
                                            tenant: selectedTenant)
                }
//                .navigationDestination(isPresented: $showAddTenantView) {
//                    AddTenantView() { tenant in
//                        viewModel.addTenant(tenant)
//                    }
//                }
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
    
    func setUpCardDetail(with tenant: UnitCardModel) {
        if tenant.isOccupied {
            viewModel.getTenant(with: tenant.unitId) { tenantToReturn in
                selectedTenant = tenantToReturn
                viewModel.selectedUnit.unitNumber = detailViewModel.safeStringToInt(tenant.unitNumber)
                showDetailView.toggle()
            }
        } else {
            showDetailView.toggle()
//            viewModel.selectedUnit.id = tenant.unitId
//            showAddTenantView.toggle()
        }
    }
}

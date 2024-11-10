import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PropertiesViewModel
    @StateObject var detailViewModel: PropertyDetailViewModel

    @State var showDetailView: Bool
    @State var showAlert = false
    @State var selectedTenant: Tennant?
    @State private var searchText = ""
    
    init(viewModel: PropertiesViewModel) {
        _showDetailView = State(initialValue: false)
        self.viewModel = viewModel
        _detailViewModel = StateObject(wrappedValue: PropertyDetailViewModel(unitManager: viewModel.manager.unitManager, tenantManager: viewModel.manager.tenantManager))
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
                .searchable(text: $searchText, prompt: "Search Unit")
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
                    UnitDetailViewContainer(propertyViewModel: viewModel, viewModel: detailViewModel,
                                            unit: detailViewModel.unit,
                                            complexName: viewModel.selectedProperty.buildingName,
                                            buildingId: viewModel.selectedProperty.buildingID,
                                            address: viewModel.selectedProperty.buildingAddress,
                                            tenant: selectedTenant)
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

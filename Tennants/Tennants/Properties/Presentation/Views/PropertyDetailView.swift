import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: PropertiesViewModel
    @State var detailViewModel = PropertyDetailViewModel()

    @State var showAlert = false
    @State var unitImage = ""
    @State private var searchText = ""
    
    init(viewModel: PropertiesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                if viewModel.selectedProperty.isSingleUnit, let unit = detailViewModel.unit {
                    UnitDetailViewContainer(propertyViewModel: viewModel, viewModel: detailViewModel,
                                            unit: unit,
                                            complexName: viewModel.selectedProperty.buildingName,
                                            buildingId: viewModel.selectedProperty.buildingID,
                                            address: viewModel.selectedProperty.buildingAddress
//                                            ,
//                                            tenant: viewModel.selectedTenant
                    )
                } else {
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
                                UnitTopCardView(imageNumber: unitModel.unitNumber,
                                                unitNumber: unitModel.unitNumber,
                                                address: viewModel.selectedProperty.buildingAddress,
                                                isOccupied: unitModel.isOccupied)
                                .onTapGesture {
                                    viewModel.setUpCardDetail(with: unitModel)
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
                    .navigationDestination(isPresented: $viewModel.showUnitDetailView) {
                        if let unit = detailViewModel.unit {
                            UnitDetailViewContainer(
                                propertyViewModel: viewModel,
                                viewModel: detailViewModel,
                                unit: unit,
                                complexName: viewModel.selectedProperty.buildingName,
                                buildingId: viewModel.selectedProperty.buildingID,
                                address: viewModel.selectedProperty.buildingAddress,
                                tenant: viewModel.selectedTenant,
                                unitImage: Image(unitImage)
                            )
                        }
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
            .onAppear {
                setUpSingleUnit()
            }
        }
    }

    func setUpSingleUnit() {
        if viewModel.selectedProperty.isSingleUnit {
            detailViewModel.fetchUnit(viewModel.selectedProperty.unitIDs.first ?? "")
            viewModel.selectedTenant = viewModel.getTenant(with: detailViewModel.unit?.tenantID ?? "")
        }
    }
}

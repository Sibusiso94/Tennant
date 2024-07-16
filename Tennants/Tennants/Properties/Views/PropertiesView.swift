import SwiftUI
import MyLibrary
import SwiftData

struct PropertiesView: View {
    let modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PropertiesViewModel
    @State var path: NavigationPath
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: PropertiesViewModel(modelContext: modelContext))
        _path = State(initialValue: NavigationPath())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.properties.isEmpty {
                        AddView(shouldShowAddProperty: $viewModel.shouldAddPropertyOptions,
                                title: "Add your first Property",
                                width: 250,
                                height: 250,
                                isNoData: viewModel.properties.isEmpty)
                    } else {
                        Spacer()
                            .frame(height: 80)
                    
                        GeometryReader { geometry in
                            LazyVGrid(columns: viewModel.columns) {
                                ForEach(Array(viewModel.properties.enumerated()), id: \.offset) { index, property in
                                    CardView(title: property.buildingName, image: Image("image\(index)"), geometry: geometry)
                                }
                                
                                VStack {
                                    AddView(shouldShowAddProperty: $viewModel.shouldAddPropertyOptions,
                                            width: 100,
                                            height: 100,
                                            isNoData: viewModel.properties.isEmpty)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: geometry.size.height / 2.5)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationDestination(isPresented: $viewModel.shouldAddPropertyOptions) {
                    PropertyOptionsView() { selectedOption in
                        if selectedOption == 1 {
                            viewModel.propertyType = .singleUnit
                        } else {
                            viewModel.propertyType = .multipleUnits
                        }
                        
                        viewModel.shouldShowAddProperty = true
                    }
                }
                .navigationDestination(isPresented: $viewModel.shouldShowAddProperty) {
                    AddPropertyView(data: $viewModel.newData, propertyOptions: viewModel.propertyType) {
                        viewModel.addProperty()
                    }
                }
//                .navigationDestination(isPresented: $showTennantView) {
//                    AddTenantView(data: $viewModel.newData, selectedProperty: viewModel.newProperty.buildingName) {
//                        viewModel.newData.isAProperty = false
//                        viewModel.addData()
//                    }
//                }
            }
        }
    }
}

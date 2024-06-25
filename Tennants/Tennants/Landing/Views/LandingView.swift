import SwiftUI
import MyLibrary

struct TennantLandingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: LandingViewModel
    @State var shouldShowAddProperty: Bool
    @State var shouldAddPropertyOptions: Bool
    @State var showTennantView: Bool
    @State var path: NavigationPath
    
    init() {
        _viewModel = StateObject(wrappedValue: LandingViewModel())
        _shouldShowAddProperty = State(initialValue: false)
        _shouldAddPropertyOptions = State(initialValue: false)
        _showTennantView = State(initialValue: false)
        _path = State(initialValue: NavigationPath())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.properties.isEmpty {
                        AddView(shouldShowAddProperty: $shouldAddPropertyOptions,
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
                                    AddView(shouldShowAddProperty: $shouldAddPropertyOptions,
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
                .navigationDestination(isPresented: $shouldAddPropertyOptions) {
                    PropertyOptionsView() { selectedOption in
                        if selectedOption == 1 {
                            viewModel.propertyType = .singleUnit
                        } else {
                            viewModel.propertyType = .multipleUnits
                        }
                        
                        shouldShowAddProperty = true
                    }
                }
                .navigationDestination(isPresented: $shouldShowAddProperty) {
                    AddPropertyView(data: $viewModel.newData, propertyOptions: viewModel.propertyType) {
                        viewModel.createProperty()
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

#Preview {
    TennantLandingView()
}

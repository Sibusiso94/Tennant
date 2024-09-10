import SwiftUI
import MyLibrary

struct PropertiesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PropertiesViewModel
    @State private var path: NavigationPath
    @State var mockProperies = ["Telesto"]
    
    init() {
        _viewModel = StateObject(wrappedValue: PropertiesViewModel())
        _path = State(initialValue: NavigationPath())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        if viewModel.properties.isEmpty {
                            Spacer()
                            AddView(title: "Add your first Property",
                                    image: Image("EmptyViewImage"),
                                    width: 250,
                                    height: 250,
                                    buttonTitle: "Add Property") {
                                viewModel.shouldAddPropertyOptions = true
                            }
                            Spacer()
                        } else {
                            Spacer()
                                .frame(height: 80)
                            
                                LazyVGrid(columns: viewModel.columns) {
                                    ForEach(Array(viewModel.properties.enumerated()), id: \.offset) { index, property in
                                        CardView(title: property.buildingName, 
                                                 image: Image("image\(index)"),
                                                 geometry: geometry) {
                                            viewModel.selectedProperty(property)
                                        }
                                    }
                                    
                                    VStack {
                                        PlusView(image: Image(systemName: "plus"), 
                                                 width: 100,
                                                 height: 100,
                                                 buttonColour: Color("DarkPastelBlue")) {
                                            viewModel.shouldAddPropertyOptions = true
                                        }
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
                            viewModel.managePropertyOptions(selectedOption)
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.shouldShowAddProperty) {
                        AddPropertyView(viewModel: viewModel) {
                            viewModel.addProperty()
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.showPropertyDetailView) {
                        withAnimation {
                            PropertyDetailView(viewModel: viewModel)
                        }
                    }
                    .alert("Property successfully added", isPresented: $viewModel.showAlert) {
                        Button("OK", role: .cancel) {
                            viewModel.selectedProperty = viewModel.manager.newProperty
                            viewModel.properties = viewModel.manager.fetchProperties()
                            viewModel.showPropertyDetailView = true
                        }
                    }
                }
            }
        }
    }
}

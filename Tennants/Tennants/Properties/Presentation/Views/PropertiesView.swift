import SwiftUI
import MyLibrary

struct PropertiesView: View {
    @Bindable var viewModel: PropertiesViewModel

    init(viewModel: PropertiesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
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
                                viewModel.showPropertyOptions()
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
                                            viewModel.showPropertyOptions()
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
                    .alert("Property successfully added", isPresented: $viewModel.showAlert) {
                        Button("OK", role: .cancel) {
                            viewModel.didConfirmPropertyAdded()
                        }
                    }
                    .onAppear {
                        viewModel.refreshData()
                    }
                }
            }
    }
}

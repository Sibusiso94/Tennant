import SwiftUI

struct TennantLandingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: LandingViewModel
    @State var shouldShowAddProperty: Bool
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    init() {
        _viewModel = StateObject(wrappedValue: LandingViewModel())
        _shouldShowAddProperty = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.properties.isEmpty {
                        AddView(shouldShowAddProperty: $shouldShowAddProperty,
                                title: "Add Prpoerty",
                                width: 250,
                                height: 250)
                    } else {
                        Spacer()
                            .frame(height: 80)
                    
                        GeometryReader { geometry in
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.properties, id: \.buildingID) { property in
                                    CardView(property: property, geometry: geometry)
                                }
                                
                                VStack {
                                    AddView(shouldShowAddProperty: $shouldShowAddProperty,
                                            width: 100,
                                            height: 100)
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
                .sheet(isPresented: $shouldShowAddProperty, content: {
                    AddNewView(data: $viewModel.newData, isAProperty: false) {
                        print(viewModel.newData)
//                        try! viewModel.realmRepository.update(insertions: [viewModel.newProperty])
                        dismiss()
                    }
                })
            }
        }
    }
}

#Preview {
    TennantLandingView()
}

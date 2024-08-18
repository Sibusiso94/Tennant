import SwiftUI
import MyLibrary

struct AddPropertyView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: PropertiesViewModel
    @State var showErrorMessage: Bool
    @State var isPropertyAdded: Bool
    
    var action: () -> Void
    
    init(viewModel: PropertiesViewModel,
         action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.action = action
        _showErrorMessage = State(initialValue: false)
        _isPropertyAdded = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        CustomTextField(text: $viewModel.newData.name, placeHolderText: "Name")
                            .focused($focusedField, equals: .name)
                            .onSubmit { self.focusNextField($focusedField) }
                        
                        CustomTextField(text: $viewModel.newData.address,
                                        placeHolderText: "Address",
                                        texFieldHeight: 100,
                                        axis: .vertical)
                            .focused($focusedField, equals: .address)
                            .onSubmit { self.focusNextField($focusedField) }
                        
                        switch viewModel.propertyType {
                        case .multipleUnits:
                            TextField("Number of Units", text: $viewModel.newData.numberOfUnits)
                                .numberTextField()
                            
                            CustomTextButton(title: "Add property") {
                                action()
                            }
                        case .singleUnit:
                            CustomTextField(text: $viewModel.newData.numberOfBedrooms, placeHolderText: "Number Of Bedrooms")
                            CustomTextField(text: $viewModel.newData.numberOfBathrooms, placeHolderText: "Number of Bathrooms")
                            
                            CustomTextButton(title: "Add property") {
                                action()
                            }
                        }
                        
                        Spacer()
                    }
                    .navigationTitle("Add a Property")
                }
            }
        }
    }
}

import SwiftUI
import MyLibrary

struct AddPropertyView: View {
    @FocusState private var isInputActive: Bool
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: PropertiesViewModel
    @State var showErrorMessage: Bool
    var isEditing: Bool

    var action: () -> Void
    
    init(viewModel: PropertiesViewModel,
         isEditing: Bool = false,
         action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.isEditing = isEditing
        self.action = action
        _showErrorMessage = State(initialValue: false)
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
                        
                        switch viewModel.propertyType {
                        case .multipleUnits:
                            CustomTextField(text: $viewModel.newData.address,
                                            placeHolderText: "Address",
                                            texFieldHeight: 100,
                                            axis: .vertical)
                                .focused($focusedField, equals: .address)
                                .onSubmit { self.focusNextField($focusedField) }

                            TextField("Number of Units", text: $viewModel.newData.numberOfUnits)
                                .numberTextField()
                        case .singleUnit:
                            CustomTextField(text: $viewModel.newData.numberOfBedrooms, placeHolderText: "Number Of Bedrooms")
                            CustomTextField(text: $viewModel.newData.numberOfBathrooms, placeHolderText: "Number of Bathrooms")
                            CustomTextField(text: $viewModel.newData.size, placeHolderText: "Size ㎡")
                        }

                        CustomTextButton(title: isEditing ? "Edit Unit" : "Add property") {
                            action()
                            dismiss()
                        }

                        Spacer()
                    }
                    .navigationTitle(isEditing ? "Edit Property" : "Add a Property")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            if isEditing {
                                Button("Cancel") {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

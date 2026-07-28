import SwiftUI
import UniformTypeIdentifiers
import MyLibrary

struct FileUploaderView: View {
    @Bindable var viewModel: FileUploaderViewModel

    init(viewModel: FileUploaderViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            VStack {
                DocumentSelectionView(
                    image: Image("\(viewModel.selectedBankType.lowercased())"),
                                      imageWidth: viewModel.selectedBankType == "Capitec" ? 300 : 200,
                                      bankTypes: viewModel.bankTypes,
                                      selectedBankType: $viewModel.selectedBankType
                )

                TextButton(title: "Select a document") {
                    viewModel.showPDFImporter.toggle()
                }
            }
            .fileImporter(
                isPresented: $viewModel.showPDFImporter,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    guard let url = urls.first else { return }
                    viewModel.isLoading = true
                    viewModel.handleImportedFile(url: url)
                case .failure(let error):
                    viewModel.errorMessage = error.localizedDescription
                    viewModel.showErrorMessage = true
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingIndicator()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showHistory()
                } label: {
                    Text("History")
                        .foregroundStyle(Color(.black.opacity(0.7)))
                }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) {
            Button("OK", role: .cancel) { }
        }
    }
}

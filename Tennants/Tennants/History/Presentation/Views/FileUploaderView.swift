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
            content()
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
    }

    @ViewBuilder
    private func content() -> some View {
        switch viewModel.state {
        case .loading:
            self
                .overlay {
                    LoadingIndicator()
                }
        case .loaded:
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
                .padding(.horizontal)
            }
            .fileImporter(
                isPresented: $viewModel.showPDFImporter,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    guard let url = urls.first else { return }
                    viewModel.handleImportedFile(url: url)
                    viewModel.state = .loaded
                case .failure(let error):
                    viewModel.state = .error(message: error.localizedDescription)
                    viewModel.showErrorMessage = true
                }
            }
        case .error(let message):
            self
                .alert(message, isPresented: $viewModel.showErrorMessage) {
                    Button("OK", role: .cancel) { }
                }
        }
    }
}

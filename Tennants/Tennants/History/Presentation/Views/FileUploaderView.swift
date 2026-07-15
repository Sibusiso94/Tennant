import SwiftUI
import UniformTypeIdentifiers
import MyLibrary

struct FileUploaderView: View {
    @State var viewModel = FileUploaderViewModel()

    init() {

    }
    
    var body: some View {
        NavigationStack {
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
                        viewModel.shouldShowResultView.toggle()
                    } label: {
                        Text("History")
                            .foregroundStyle(Color(.black.opacity(0.7)))
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.shouldShowResultView) {
                ZStack {
                    Color("PastelGrey")
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            ForEach(viewModel.tenantHistoryData) { history in
                                HistoryView(heading: history.date, tenantInfo: history.data)
                            }
                        }
                    }
                }
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

import SwiftUI
import MyLibrary

struct FileUploaderView: View {
    @StateObject var viewModel: FileUploaderViewModel
    @State var isCompleteUploading = false

    init() {
        _viewModel = StateObject(wrappedValue: FileUploaderViewModel())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                VStack {
                    DocumentSelectionView(image: Image("\(viewModel.selectedBankType.lowercased())"),
                                          imageWidth: viewModel.selectedBankType == "Capitec" ? 300 : 200,
                                          bankTypes: viewModel.bankTypes,
                                          selectedBankType: $viewModel.selectedBankType)
                    
//                    if isCompleteUploading {
                        CustomTextButton(title: "Process document") {
                            Task {
                                await viewModel.handleData()
                            }
                        }
//                    } else {
//                        CustomTextButton(title: "Select a document") {
//                            viewModel.showPDFImporter.toggle()
//                        }
//                    }
                }
                .sheet(isPresented: $viewModel.showPDFImporter) {
                    DocumentPicker() { url in
                        isCompleteUploading = true
                        viewModel.isLoading = true
                        viewModel.handleImportedFile(url: url)
                    }
                }
            }
//            .navigationTitle("Select a PDF")
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
            .overlay {
                if viewModel.isLoading {
                    LoadingView(title: "Processing...")
                }
            }
        }
    }
}

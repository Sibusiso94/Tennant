import SwiftUI
import MyLibrary

struct FileUploaderView: View {
    @StateObject var viewModel: FileUploaderViewModel
    
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
                    
                    if viewModel.isLoading {
                        CustomTextButton(title: "Process document") {
                            viewModel.fetchApiData()
                        }
                    } else {
                        CustomTextButton(title: "Select a document") {
                            viewModel.isLoading = true
                            viewModel.showPDFImporter.toggle()
                        }
                    }
                }
                .sheet(isPresented: $viewModel.showPDFImporter) {
                    DocumentPicker() { url in
                        viewModel.handleImportedFile(url: url)
                    }
                }
            }
//            .navigationTitle("Select a PDF")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.getTenantData()
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

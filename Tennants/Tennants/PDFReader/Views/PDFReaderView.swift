import SwiftUI
import MyLibrary

struct PDFReaderView: View {
    @StateObject var fileManager: FPDDataManager
    @StateObject var apiManager: ApiDataManager
    
    init() {
        _fileManager = StateObject(wrappedValue: FPDDataManager())
        _apiManager = StateObject(wrappedValue: ApiDataManager())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                VStack {
                    DocumentSelectionView(image: Image("\(fileManager.selectedBankType.lowercased())"),
                                          imageWidth: fileManager.selectedBankType == "Capitec" ? 300 : 200,
                                          bankTypes: fileManager.bankTypes,
                                          selectedBankType: $fileManager.selectedBankType)
                    
                    if fileManager.isCompleteUploading {
                        CustomTextButton(title: "Process document") {
                            apiManager.fetchApiData(storagePath: fileManager.fileStoragePath)
                            fileManager.isCompleteUploading = false
                        }
                    } else {
                        CustomTextButton(title: "Select a document") {
                            apiManager.selectedBankType = fileManager.selectedBankType
                            fileManager.isCompleteUploading = true
                            fileManager.showPDFImporter.toggle()
                        }
                    }
                }
                .sheet(isPresented: $fileManager.showPDFImporter) {
                    DocumentPicker() { url in
                        fileManager.handleImportedFile(url: url)
                    }
                }
            }
//            .navigationTitle("Select a PDF")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        apiManager.shouldShowResultView.toggle()
                    } label: {
                        Text("History")
                            .foregroundStyle(Color(.black.opacity(0.7)))
                    }
                }
            }
            .navigationDestination(isPresented: $apiManager.shouldShowResultView) {
                ZStack {
                    Color("PastelGrey")
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            ForEach(apiManager.allHistoryData) { history in
                                HistoryView(history: history)
                            }
                        }
                    }
                }
            }
            .overlay {
                if apiManager.isLoading {
                    LoadingView(title: "Processing...")
                }
            }
        }
    }
}

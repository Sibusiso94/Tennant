import SwiftUI
import SwiftData
import MyLibrary

struct PDFReaderView: View {
    @StateObject var fileManager: FPDDataManager
    @StateObject var apiManager: ApiDataManager
    
    init(modelContext: ModelContext) {
        _fileManager = StateObject(wrappedValue: FPDDataManager())
        _apiManager = StateObject(wrappedValue: ApiDataManager(modelContext: modelContext))
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
                            apiManager.fetchApiData(selectedBankType: fileManager.selectedBankType, storagePath: fileManager.storagePath)
                            fileManager.isCompleteUploading = false
                        }
                    } else {
                        CustomTextButton(title: "Select a document") {
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
                    ZStack {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(Color("PastelBlue"))
                }
            }
        }
    }
}

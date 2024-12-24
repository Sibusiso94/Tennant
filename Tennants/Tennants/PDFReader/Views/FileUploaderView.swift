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
                    
                    ProgressTextButton(title: viewModel.isCompleteUploading ? "Process document" : "Select a document",
                                       isLoading: $viewModel.isLoading) {
                        viewModel.isCompleteUploading ? viewModel.handleData() : viewModel.showPDFImporter.toggle()
                    }
                }
                .sheet(isPresented: $viewModel.showPDFImporter) {
                    DocumentPicker() { url in
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
        }
    }
}

public struct ProgressTextButton: View {
    var title: String
    @Binding var isLoading: Bool
    var action: () -> Void

    public init(title: String,
                isLoading: Binding<Bool>,
                action: @escaping () -> Void) {
        self.title = title
        self._isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(Color.black.opacity(0.6))

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .customHorizontalPadding(isButton: true)
    }
}

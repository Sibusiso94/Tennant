import SwiftUI
import UniformTypeIdentifiers
import MyLibrary

struct PDFReaderView: View {
    @State private var showPDFImporter: Bool = false
    @State private var selectedBankImage: String = ""
    @StateObject var fileManager = FPDDataManager()
    
    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            VStack {
                if let results = fileManager.results {
                    ForEach(results, id: \.reference) { result in
                        VStack {
                            Text(result.reference)
                            Text(result.amount)
                            Text(result.date)
                        }
                    }
                } else {
                    DocumentSelectionView(image: Image("\(fileManager.selectedBankType.lowercased())"),
                                          imageWidth: fileManager.selectedBankType == "Capitec" ? 300 : 200,
                                          bankTypes: fileManager.bankTypes,
                                          selectedBankType: $fileManager.selectedBankType) {
                        showPDFImporter.toggle()
                    }
                }
            }
            .fileImporter(isPresented: $showPDFImporter, allowedContentTypes: [UTType.pdf]) { result in
                switch result {
                case .success(let url):
                    fileManager.handleImportedFile(url: url)
                case .failure(let error):
                    print("Importer error: \(error)")
                }
            }
        }
    }
}

#Preview {
    PDFReaderView()
}

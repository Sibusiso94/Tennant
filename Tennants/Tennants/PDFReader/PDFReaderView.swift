import SwiftUI
import MyLibrary

struct PDFReaderView: View {
    @State private var presentImporter = false
    @State var pdfURL: URL?
    @State var showTestView = false
    let pdfManager = FPDDataManager()
    
    var body: some View {
        VStack {
            PDFReader(buttonTitle: "Import") { url, error in
                if let url = url {
                    print("=== PDF URL ===")
                    print(url)
                    pdfManager.uploadFile(url: url)
                } else if let error {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    PDFReaderView()
}

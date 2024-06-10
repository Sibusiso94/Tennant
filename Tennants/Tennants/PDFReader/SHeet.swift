import SwiftUI
import UniformTypeIdentifiers

struct SHeet: View {
    @State private var showPDFImporter = false
    @AppStorage("bookmarkData") var downloadsBookmark: Data?
    var url: URL
    
    var body: some View {
        VStack {
            Button("Select and Save PDF to downloads directory") {
                showPDFImporter.toggle()
            }
        }
        
        .fileImporter(isPresented: $showPDFImporter, allowedContentTypes: [UTType.pdf]) { result in
            switch result {
            case .success(let url):
                handlePDFSelection(url: url)
            case .failure(let error):
                print("Importer error: \(error)")
            }
        }
    }
    
    private func handlePDFSelection(url: URL) {
        guard let bookmarkData = downloadsBookmark else {
            print("No downloads directory set")
            return
        }

        var isStale = false
        do {
            let downloadsUrl = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale)
            
            guard !isStale else {
                print("Bookmark is stale")
                return
            }

            guard downloadsUrl.startAccessingSecurityScopedResource() else {
                print("Failed to access security scoped resource for downloads directory")
                return
            }

            defer { downloadsUrl.stopAccessingSecurityScopedResource() }

            let destinationUrl = downloadsUrl.appendingPathComponent(url.lastPathComponent)
            try FileManager.default.copyItem(at: url, to: destinationUrl)
            print("File moved to: \(destinationUrl)")
        } catch {
            print("Error resolving bookmark: \(error)")
        }
    }
}

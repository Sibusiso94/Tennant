import SwiftUI
import UniformTypeIdentifiers
import MyLibrary

struct Test: View {
    @State private var showFileImporter = false
    @State private var fileAccessed = false
    @State var showSheet = false
    @AppStorage("bookmarkData") var downloadsBookmark: Data?
    @State var urlselected: URL?
    
    var networkingManager = NetworkManagerConcreation()

    var body: some View {
        VStack {
            Button("Set downloads directory") {
                showFileImporter.toggle()
            }
        }
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [UTType.folder]) { result in
            print("File importer for folder presented")
            switch result {
            case .success(let url):
                print("Folder selected: \(url)")
                handleFolderSelection(url: url)
                self.urlselected = url
            case .failure(let error):
                print("Importer error: \(error)")
            }
        }
        .sheet(isPresented: $showSheet, content: {
            if let url = urlselected {
                SHeet(url: url)
            }
        })
    }

    private func handleFolderSelection(url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to access security scoped resource for folder")
            return
        }

        defer { url.stopAccessingSecurityScopedResource() }

        do {
            downloadsBookmark = try url.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
            print("Downloads directory set successfully")
            showSheet = true
        } catch {
            print("Bookmark error \(error)")
        }
    }
}

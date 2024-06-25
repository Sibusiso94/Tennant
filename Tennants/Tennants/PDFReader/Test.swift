
import Foundation
import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // No updates needed for this example
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let manager = FPDDataManager()
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            // Get bookmark data from the provided URL
            let bookmarkData = try? url.bookmarkData()
            if let data = bookmarkData {
                // Save data
                print("==================")
                print("Data saved")
            }

            // Access to an external document by the bookmark data
            if let data = bookmarkData {
                var stale = false
                if let url = try? URL(resolvingBookmarkData: data, bookmarkDataIsStale: &stale),
                   stale == false,
                   url.startAccessingSecurityScopedResource()
                {
                    var error: NSError?
                    NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { readURL in
//                        if let data = try? Data(contentsOf: readURL) {
                            manager.handleImportedFile(url: readURL)
//                        }
                    }
                    
                    url.stopAccessingSecurityScopedResource()
                }
            }
            
            // Start accessing a security-scoped resource.
//            guard url.startAccessingSecurityScopedResource() else {
//                // Handle the failure here.
//                return
//            }

            // Make sure you release the security-scoped resource when you finish.
//            defer { url.stopAccessingSecurityScopedResource() }

            // Use file coordination for reading and writing any of the URL’s content.
//            var error: NSError? = nil
//            NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { (url) in
//                let keys: [URLResourceKey] = [.nameKey, .isDirectoryKey]
//
//                // Get an enumerator for the directory's content.
//                guard let fileList = FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
//                    Swift.debugPrint("*** Unable to access the contents of \(url.path) ***\n")
//                    return
//                }
//
//                for case let file as URL in fileList {
//                    // Start accessing the content's security-scoped URL.
//                    guard file.startAccessingSecurityScopedResource() else {
//                        // Handle the failure here.
//                        continue
//                    }
//
//                    // Do something with the file here.
//                    Swift.debugPrint("chosen file: \(file.lastPathComponent)")
//                    if let url = URL(string: file.lastPathComponent) {
//                        manager.handleImportedFile(url: url)
//                    }
//
//                    // Make sure you release the security-scoped resource when you finish.
//                    file.stopAccessingSecurityScopedResource()
//                }
//            }
        }
    }
}

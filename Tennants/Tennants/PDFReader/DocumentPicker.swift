
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
                        manager.handleImportedFile(url: readURL)
                    }
                    
                    url.stopAccessingSecurityScopedResource()
                }
            }
        }
    }
}

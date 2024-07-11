import Foundation
import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
    var completion: (URL) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completion)
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
        var completion: (URL) -> Void
        
        init(completion: @escaping (URL) -> Void) {
            self.completion = completion
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])  {
            guard let url = urls.first else { return }
            handlePickedDocument(at: url)
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // Handle cancellation if needed
        }
        
        func handlePickedDocument(at url: URL) {
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
                   url.startAccessingSecurityScopedResource() {
                    var error: NSError?
                    NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { readURL in
                        completion(readURL)
                    }
                    
                    url.stopAccessingSecurityScopedResource()
                }
            }
        }
    }
}

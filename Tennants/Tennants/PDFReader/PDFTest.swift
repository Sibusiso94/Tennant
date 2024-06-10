import Foundation

class PDFTest {
    func getPDF(url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to start accessing security-scoped resource")
            return
        }

        defer { url.stopAccessingSecurityScopedResource() }

        let fileCoordinator = NSFileCoordinator()
        var error: NSError? = nil
        fileCoordinator.coordinate(readingItemAt: url, error: &error) { (url) in
            let keys: [URLResourceKey] = [.nameKey, .isDirectoryKey]

            guard let fileList = FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
                print("*** Unable to access the contents of \(url.path) ***")
                return
            }

            for case let file as URL in fileList {
                guard file.startAccessingSecurityScopedResource() else {
                    print("Failed to start accessing security-scoped resource for file: \(file.lastPathComponent)")
                    continue
                }

                print("Chosen file: \(file.lastPathComponent)")

                file.stopAccessingSecurityScopedResource()
            }
        }

        if let error = error {
            print("File coordination error: \(error)")
        }
    }
}

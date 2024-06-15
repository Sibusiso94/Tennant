import Foundation
import SwiftUI
import FirebaseStorage
import PDFKit

protocol PDFManager {
    func handleImportedFile(url: URL)
    func uploadFile(url: Data?)
    func validateFileURL(_ fileURL: URL) -> Bool
}

protocol FileDataManager {
    var url: URL { get }
    func uploadFile()
}

final class FPDDataManager: ObservableObject, PDFManager {
    var networkingManager = NetworkManagerConcreation()
    let storageRef = Storage.storage().reference()
    var bankTypes: [String] = ["Standard", "FNB", "Capitec"]
    @Published var selectedBankType = "Standard"
    @Published var results: [TenantData]?
    
    init() {
        
    }
    
    func handleImportedFile(url: URL) {
        if validateFileURL(url) {
//            guard let safeURL = securelyAccessURL(url: url) else { return }
            
            do {
                let data = try Data(contentsOf: url)
                uploadFile(url: data)
            } catch {
                print("Error reading file data: \(error.localizedDescription)")
            }
        }
    }
    
    internal func uploadFile(url: Data?) {
        guard let localFile = url else { return }
        let date = Date.now

        #warning("Get userID/name to pass in to make folder unique")
        let statementRef = storageRef.child("statements/statement_\(date).pdf")
        if let url = url {
            _ = statementRef.putData(localFile, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    print("Uh-oh, an error occurred: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                let size = metadata.size
                let name = metadata.name ?? ""
                let type = metadata.contentType ?? ""
                print("================================")
                print("PDF info: \n\(size) \n\(name) \n\(type)")
                
                statementRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                }
            }
        }
    }
    
    func securelyAccessURL(url: URL) -> URL? {
        var documentURL: URL?
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to start accessing security-scoped resource")
            return nil
        }

        defer { url.stopAccessingSecurityScopedResource() }

        let fileCoordinator = NSFileCoordinator()
        var error: NSError? = nil
        fileCoordinator.coordinate(readingItemAt: url, error: &error) { [weak self] (url) in
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
                documentURL = file

                file.stopAccessingSecurityScopedResource()
            }
        }

        if let error = error {
            print("File coordination error: \(error)")
        }
        
        return documentURL
    }
    
    internal func validateFileURL(_ fileURL: URL) -> Bool {
        let fileManager = FileManager.default
        
        // Check if the URL is a file URL
        guard fileURL.isFileURL else {
            print("The URL is not a file URL.")
            return false
        }
        
        do {
            // Get file attributes
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)
            
            // Check if the URL is a directory
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                print("The URL is a directory.")
                return false
            }
            
            // Check if the URL is a symbolic link
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                print("The URL is a symbolic link.")
                return false
            }
        } catch {
            // Handle the error if the file does not exist or cannot be accessed
            print("The URL is invalid or cannot be accessed: \(error.localizedDescription)")
            return false
        }
        
        // If all checks pass, the URL is valid
        return true
    }
    
    func fetchUserData() {
        let url = networkingManager.setUpURL(bankType: selectedBankType)
        networkingManager.fetchUserData(apiURL: url) { tenants in
            self.results = tenants
        }
    }
}

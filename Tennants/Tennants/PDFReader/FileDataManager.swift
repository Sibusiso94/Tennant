import Foundation
import FirebaseStorage
import PDFKit

protocol FileDataManager {
    var url: URL { get }
    func uploadFile()
}

final class FPDDataManager: ObservableObject {
    let storageRef = Storage.storage().reference()
    @Published var tenantsData: [TenantData] = []
    init() {
        
    }
    
//    var url: URL
//    
//    init(url: URL) {
//        self.url = url
//    }
    
    func uploadFile(url: Data?) {
        guard let localFile = url else { return }
        let date = Date.now

        #warning("Get userID/name to pass in to make folder unique")
        let statementRef = storageRef.child("statements/statement_\(date).pdf")
        if let url = url {
            let uploadTask = statementRef.putData(localFile, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    print("Uh-oh, an error occurred: \(error?.localizedDescription)")
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                let name = metadata.name ?? ""
                let type = metadata.contentType ?? ""
                print("================================")
                print("PDF info: \n\(size) \n\(name) \n\(type)")
                // You can also access to download URL after upload.
                //          statementRef.downloadURL { (url, error) in
                //            guard let downloadURL = url else {
                //              // Uh-oh, an error occurred!
                //              return
                //            }
                //          }
            }
        }
    }
    
    func validateFileURL(_ fileURL: URL) -> Bool {
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
}

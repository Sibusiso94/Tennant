import Foundation
import FirebaseFirestore
import FirebaseStorage
import OSLog

protocol CreateMultipleObjects {
    associatedtype T
    func create(_ object: [T], completion: (Result<Void, Error>) -> Void)
}

protocol PDFUploadable {
    func uploadFile(url: Data?, fileStoragePath: String, completion: @escaping (String?, Error?) -> Void)
}

class FirebaseRepository: CreateMultipleObjects, PDFUploadable {
    typealias T = Reference
    
    private var db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func create(_ object: [Reference], completion: (Result<Void, any Error>) -> Void) {
        do {
          try db.collection("references").document("Date").setData(from: object)
        } catch let error {
          print("Error writing city to Firestore: \(error)")
        }
    }
    
    
    func uploadFile(url: Data?, fileStoragePath: String, completion: @escaping (String?, Error?) -> Void) {
        guard let localFile = url else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "application/pdf"
        
        let statementRef = storageRef.child(fileStoragePath)
        if let url = url {
            _ = statementRef.putData(localFile, metadata: metadata) { metadata, error in
                guard let metadata = metadata else {
                    os_log("An error occurred: %@", type: .debug,  error?.localizedDescription ?? "Failed to reading metadata")
                    completion(nil, error)
                    return
                }
                
                let name = metadata.name ?? ""
                completion("PDF file \(name) uploaded successfully", nil)
            }
        }
    }
}

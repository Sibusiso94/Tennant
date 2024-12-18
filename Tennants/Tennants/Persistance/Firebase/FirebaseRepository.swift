//import Foundation
//import FirebaseFirestore
//import FirebaseStorage
//import OSLog
//import MyLibrary
//
//protocol CreateMultipleObjects {
//    associatedtype T
//    func create(_ object: T, completion: @escaping (Error?) -> Void) async
//}
//
//protocol PDFUploadable {
//    func uploadFile(url: Data?, fileStoragePath: String, completion: @escaping (String?, Error?) -> Void)
//}
//
//class FirebaseRepository: CreateMultipleObjects, PDFUploadable {
//    typealias T = Reference
//    
//    private var db = Firestore.firestore()
//    let storageRef = Storage.storage().reference()
//    
//    func create(_ objects: Reference, completion: @escaping (Error?) -> Void) async {
//        do {
//          try await db.collection("userID").document("References").setData([
//            "date": setDate(),
//            "reference": objects.references
//          ])
//          print("Document successfully written!")
//            completion(nil)
//        } catch {
//          print("Error writing document: \(error)")
//            completion(error)
//        }
//    }
//
//    func getDocumentId() -> String {
//        let docID = self.db.collection("userID").document("References").documentID
//        return docID
//    }
//
//    private func setDate() -> String {
//        let date = Date.now
//        let day = date.formatted(.dateTime.weekday(.twoDigits))
//        let month = date.formatted(.dateTime.month(.twoDigits))
//        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
//        return String(year)
//    }
//
//    func uploadFile(url: Data?, fileStoragePath: String, completion: @escaping (String?, Error?) -> Void) {
//        guard let localFile = url else { return }
//        let metadata = StorageMetadata()
//        metadata.contentType = "application/pdf"
//        
//        let statementRef = storageRef.child(fileStoragePath)
//        if let url = url {
//            _ = statementRef.putData(localFile, metadata: metadata) { metadata, error in
//                guard let metadata = metadata else {
//                    os_log("An error occurred: %@", type: .debug,  error?.localizedDescription ?? "Failed to reading metadata")
//                    completion(nil, error)
//                    return
//                }
//                
//                let name = metadata.name ?? ""
//                completion("PDF file \(name) uploaded successfully", nil)
//            }
//        }
//    }
//}

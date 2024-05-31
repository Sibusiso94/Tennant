import Foundation
import FirebaseStorage

protocol FileDataManager {
    var url: URL { get }
    func uploadFile()
}

class FPDDataManager {
    let storageRef = Storage.storage().reference()
//    var url: URL
//    
//    init(url: URL) {
//        self.url = url
//    }
    
    func uploadFile(url: URL) {
        let localFile = url
        let date = Date.now

        #warning("Get userID/name to pass in to make folder unique")
        let statementRef = storageRef.child("statements/statement_\(date).pdf")

        let uploadTask = statementRef.putFile(from: localFile, metadata: nil) { metadata, error in
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

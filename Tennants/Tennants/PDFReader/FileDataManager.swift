import Foundation
import SwiftUI
import OSLog

protocol PDFManager {
    var bankTypes: [String] { get }
    var selectedBankType: String { get set }
    var validationManager: ValidationManager { get set }

    func handleImportedFile(url: URL) async
}

class ValidationManager {
    func validateFileURL(_ fileURL: URL) -> Bool {
        let fileManager = FileManager.default
        
        guard fileURL.isFileURL else {
            os_log("The URL is not a file URL.", type: .debug)
            return false
        }
        
        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)
            
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                os_log("The URL is a directory.", type: .debug)
                return false
            }
            
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                os_log("The URL is a symbolic link.", type: .debug)
                return false
            }
        } catch {
            os_log("The URL is invalid or cannot be accessed:", type: .debug, error.localizedDescription)
            return false
        }
        
        return true
    }
}

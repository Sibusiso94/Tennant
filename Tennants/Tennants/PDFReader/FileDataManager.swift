import Foundation
import SwiftUI
import OSLog

protocol PDFManager {
    var bankTypes: [String] { get }
    var selectedBankType: String { get set }

    func validateFileURL(_ fileURL: URL) -> Bool
    func handleImportedFile(url: URL) async
}

enum ValidationErrors: String, Error, CaseIterable {
    case notFileUrl = "The URL is not a file URL."
    case notADirectory = "The URL is a directory."
    case isAsymbolLink = "The URL is a symbolic link."
//    case invalidOrInaccessable = 

    var localizedDescription: String {
            return self.rawValue
    }
}

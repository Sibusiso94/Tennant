import Foundation

enum FileErrorMessages: String, CaseIterable {
    case failedToFetchFile = "Your PDF file was not uploaded."
    case failedToUploadReferences = "Your Tenant Payment Info was not fetched. \nTry again later."
}

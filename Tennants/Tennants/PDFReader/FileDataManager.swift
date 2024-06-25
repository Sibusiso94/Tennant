import Foundation
import SwiftUI
import FirebaseStorage
import PDFKit
import OSLog

protocol PDFManager {
//    var networkManager: NetworkManagerConcreation { get }
    func handleImportedFile(url: URL)
    func uploadFile(url: Data?)
    func validateFileURL(_ fileURL: URL) -> Bool
}

protocol FileDataManager {
    var url: URL { get }
    func uploadFile()
}

final class FPDDataManager: ObservableObject, PDFManager {
//    var networkManager: NetworkManagerConcreation
    
    var networkingManager = NetworkManagerConcreation()
    let storageRef = Storage.storage().reference()
    var bankTypes: [String] = ["Standard", "FNB", "Capitec"]
    
    @Published var selectedBankType = "Standard"
    @Published var isCompletePayment = true
    @Published var results: [TenantData]?
    
    @Published var isLoading = false
    @Published var hasError: Bool = false
    @Published var error: TenantError?
    
    @Published var showPDFImporter: Bool = false
    @Published var shouldShowResultView: Bool = false
    
    init() {
        
    }
    
    func handleImportedFile(url: URL) {
        if validateFileURL(url) {
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
            }
        }
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
       isLoading = true
        let url = networkingManager.setUpURL(bankType: selectedBankType)
        networkingManager.fetchUserData(apiURL: url) { [weak self] tenants in
            self?.results = tenants
            self?.filterAllPayments(tenants: self?.results)
            self?.showPDFImporter = false
            self?.isLoading = false
            self?.shouldShowResultView = true
        }
        
        hasError = networkingManager.hasError
        error = networkingManager.error
    }
    
    private func filterAllPayments(tenants: [TenantData]?) {
        guard let tenants = tenants else { return }
        for (index, tenant) in tenants.enumerated() {
            results?[index].amount = tenant.amount.replacingOccurrences(of: "\"", with: "")
        }
    }
    
    private func cleanPaymentAmount(amount: String) -> String {
        let cleanAmount = amount.replacingOccurrences(of: "\"", with: "")
        return cleanAmount
    }
    
    func isPaymentComplete(amount: String) -> Bool {
        guard let amount = Double(amount) else { return false }
        
        if amount > 600 {
            return true
        } else {
            return false
        }
    }
}

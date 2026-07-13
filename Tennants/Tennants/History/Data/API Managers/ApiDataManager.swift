import Foundation
import OSLog

protocol APIManager {
    func fetchApiData(selectedBankType: String, userId: String, storagePath: String) async throws -> [TenantPaymentData]
}

class ApiDataManager: APIManager {
    let networkingManager: NetworkServiceProtocol

    var baseURL = "http://192.168.1.44:5000/api/fetchingAndReturning?"
    
    init(networkingManager: NetworkServiceProtocol) {
        self.networkingManager = networkingManager
    }
    
    func fetchApiData(
        selectedBankType: String,
        userId: String,
        storagePath: String
    ) async throws -> [TenantPaymentData] {
        let url = networkingManager.createURL(
            baseURL: baseURL,
            parameters: [
                ("bankType", selectedBankType),
                ("userId", "userId"),
                ("storagePath", storagePath)
            ]
        )
        
        guard let url = url else {
            throw ApiError.invalidUrl
        }

        return try await networkingManager.fetchData(from: url.absoluteString)
    }
    
    func uploadFile(url: Data?, bankType: String, completion: @escaping (String?, Error?) -> Void) {
        guard let localFile = url else { return }
        
//        let fileStoragePath = setUpStoragePath(bankType)
//        firebaseRepository.uploadFile(url: url, fileStoragePath: fileStoragePath) { message, error in
//            if let error = error {
//                completion(nil, error)
//            }
//            completion(fileStoragePath, nil)
//        }
    }
    
//    internal func setUpStoragePath(_ selectedBankType: String) -> String {
//        let date = Date.now
//        let day = date.formatted(.dateTime.weekday(.twoDigits))
//        let month = date.formatted(.dateTime.month(.twoDigits))
//        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
//        return "statements/userID/\(day)_\(month)_\(year)_\(selectedBankType)_statement.pdf"
//    }
}

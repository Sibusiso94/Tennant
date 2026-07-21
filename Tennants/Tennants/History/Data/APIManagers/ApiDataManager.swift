import Foundation
import OSLog

class ApiDataManager: APIManager {
    let networkingManager: NetworkServiceProtocol

    var baseURL = "http://127.0.0.1:5000/api/fetchingAndReturning?"

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
}

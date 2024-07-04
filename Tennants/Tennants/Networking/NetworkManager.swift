import Foundation

protocol NetworkManager {
    func setUpURL(bankType: String, reference: String, storagePath: String) -> String
    func fetchUserData(apiURL: String, completion: @escaping ([TenantData]) -> ())
}

enum TenantError: LocalizedError {
    case failedToDecode
    case noDataReceived
    case invalidUrl
    case custom(error: Error)
    case invalidResponse(response: String)
    
    var errorDescription: String? {
        switch self {
        case .failedToDecode:
            return "Failed to decode response"
        case .noDataReceived:
            return "No data received"
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse(let response):
            return "Invalid response received: \(response)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}

final class NetworkManagerConcreation: NetworkManager {
    var hasError = false
    var error: TenantError?
    
    func setUpURL(bankType: String = "Standard",
                  reference: String = "STANSAL",
                  storagePath: String = "statements/StandardBank.pdf") -> String {
        let apiURL = "http://192.168.1.43:8080/api/fetchingAndReturning?bankType=\(bankType)&referenceName=\(reference)&storagePath=\(storagePath)"
        return apiURL
    }
    
    func fetchUserData(apiURL: String, completion: @escaping ([TenantData]) -> ()) {
        if let url = URL(string: apiURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.hasError = true
                        self?.error = TenantError.custom(error: error)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        self?.hasError = true
                        self?.error = TenantError.invalidResponse(response: String(describing: response))
                        return
                    }
                    
                    guard let data = data else {
                        self?.hasError = true
                        self?.error = TenantError.noDataReceived
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let tenantData = try decoder.decode([TenantData].self, from: data)
                        completion(tenantData)
                    } catch {
                        self?.hasError = true
                        self?.error = TenantError.custom(error: error)
                    }
                }
            }
            .resume()
        } else {
            hasError = true
            error = TenantError.invalidUrl
        }
    }
}

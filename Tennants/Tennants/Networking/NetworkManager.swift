import Foundation

enum ApiError: LocalizedError {
    case failedToDecode
    case noDataReceived
    case invalidUrl
    case fileValidationFailure
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
        case .fileValidationFailure:
            return "The file could not be validated.\nPlease try again."
        case .invalidResponse(let response):
            return "Invalid response received: \(response)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func createURL(baseURL: String, parameters: [(String, String)]) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }

    func fetchData<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        let (data, response) = try await session.data(from: url)
        let validData = try mapResponse(data: data, response: response)
        do {
            return try decoder.decode(T.self, from: validData)
        } catch {
            throw ApiError.failedToDecode
        }
    }

    private func mapResponse(data: Data, response: URLResponse) throws -> Data {
        guard let http = response as? HTTPURLResponse else { return data }
        guard (200..<300).contains(http.statusCode) else {
            throw ApiError.invalidResponse(response: "\(http.statusCode)")
        }
        return data
    }
}

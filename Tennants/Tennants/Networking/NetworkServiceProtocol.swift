import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(from urlString: String) async throws -> T
    func createURL(baseURL: String, parameters: [(String, String)]) -> URL?
}

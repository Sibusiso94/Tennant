import Foundation

protocol NetworkManager {
    associatedtype T: Decodable
    
    var hasError: Bool { get set }
    var error: ApiError? { get set }
    
    func createURL(baseURL: String, parameters: [(String, String)]) -> URL?
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, ApiError>) -> Void)
}

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

final class NetworkManagerConcreation: NetworkManager {
    typealias T = TenantPaymentData
    var hasError = false
    var error: ApiError?
    
    func createURL(baseURL: String, parameters: [(String, String)]) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
    
//    func createURL(baseURL: String, parameters: [(String, Any)]) -> URL? {
//        var components = URLComponents(string: baseURL)
//        components?.queryItems = parameters.flatMap { (name, value) -> [URLQueryItem] in
//            if let array = value as? [String] {
//                return [URLQueryItem(name: name, value: array.joined(separator: ","))]
//            } else {
//                return [URLQueryItem(name: name, value: "\(value)")]
//            }
//        }
//        return components?.url
//    }
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, ApiError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.handleError(ApiError.custom(error: error), completion: completion)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    self?.handleError(ApiError.invalidResponse(response: String(describing: response)), completion: completion)
                    return
                }
                
                guard let data = data else {
                    self?.handleError(ApiError.noDataReceived, completion: completion)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let resultData = try decoder.decode(T.self, from: data)
                    completion(.success(resultData))
                } catch {
                    self?.handleError(ApiError.custom(error: error), completion: completion)
                }
            }
        }.resume()
    }
    
    private func handleError<T>(_ error: ApiError, completion: (Result<T, ApiError>) -> Void) {
        self.hasError = true
        self.error = error
        completion(.failure(error))
    }
}

//private func fetchDevices() async throws -> [Device] {
//    return try await withCheckedThrowingContinuation { continuation in
//        devicesProvider.fetchDevices { devices, error in
//            if let error = error {
//                continuation.resume(throwing: error)
//            } else {
//                continuation.resume(returning: devices)
//            }
//        }
//    }
//}

//func fetch() async throws -> Dashboard? {
//    let vitalityDataResponse: VitalityDataResponse = try await withCheckedThrowingContinuation { continuation in
//        api.getVitalityData { response, error in
//            if let response = response {
//                continuation.resume(returning: response)
//            } else {
//                continuation.resume(throwing: error ?? VitalityAPIError.other)
//            }
//
//        }
//    }
//
//    let isHealthReviewRequired: Bool = try await withCheckedThrowingContinuation { continuation in
//        fetchHealthReviewStatus { response in
//            if let response = response {
//                continuation.resume(returning: response)
//            } else {
//                continuation.resume(throwing: VitalityAPIError.other)
//            }
//        }
//    }
//
//    let caffeNeroRepsonse: CaffeNeroPartner.CaffeNeroReward? = try await withCheckedThrowingContinuation { continuation in
//        fetchCaffeNeroResponse(vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.caffeNeroEligibility) { response in
//            if let response {
//                continuation.resume(returning: response)
//            } else  {
//                continuation.resume(throwing: VitalityAPIError.other)
//            }
//        }
//    }
//
//    let vitalityProfile = VitalityProfile(response: vitalityDataResponse, isHealthReviewRequired: isHealthReviewRequired)
//
//    let amexReward = AmexRewardParser.parseAmex(vitalityDataResponse.member?.vitalityProfile?.vitalityPolicy?.planType,
//                                                vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.partners)
//
//    let cinemaReward = CinemaRewardParser.parseCinema(vitalityDataResponse.member?.vitalityProfile?.vitalityPolicy?.planType,
//                                                      vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.partners,
//                                                      vitalityDataResponse.member?.vitalityProfile?.vitalityPolicy?.members,
//                                                      isHealthReviewRequired)
//
//    let rakutenHealthyLivingReward = RakutenHealthyLivingRewardParser.parseRakuten(vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.partners, isHealthReviewRequired)
//
//    let mindfulChefReward = MindfulChefRewardParser.parseMindfulChef(vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.partners)
//
//    let eligibleRewards = vitalityDataResponse.member?.vitalityProfile?.eligibleRewards
//    let appleWatchReward = AppleWatchReward(response: eligibleRewards?.appleWatchRewardEligibility)
//    let amazonPrimeReward = AmazonPrimeReward(response: eligibleRewards?.amazonPrimeRewardEligibility)
//    let waitroseReward = WaitroseReward(response: eligibleRewards?.waitroseEligibility)
//    let dashboard = Dashboard(vitalityProfile: vitalityProfile,
//                              caffeNeroReward: caffeNeroRepsonse,
//                              cinemaReward: cinemaReward,
//                              appleWatchReward: appleWatchReward,
//                              amazonPrimeReward: amazonPrimeReward,
//                              waitroseReward: waitroseReward,
//                              amexReward: amexReward,
//                              rakutenHealthyLivingReward: rakutenHealthyLivingReward,
//                              mindfulChefReward: mindfulChefReward)
//
//    analyticsCapturer.logDashboardUserProperties(dashboard: dashboard,
//                                                 initiatingPolicies: vitalityDataResponse.member?.vitalityProfile?.vitalityPolicy?.initiatingPolicies,
//                                                 vitalityPartners: vitalityDataResponse.member?.vitalityProfile?.eligibleRewards?.partners)
//    return dashboard
//
//}

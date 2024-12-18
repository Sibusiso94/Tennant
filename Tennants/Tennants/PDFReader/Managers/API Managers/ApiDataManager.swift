import Foundation
import OSLog

protocol APIManager {
    var baseURL: String { get }
    
    func fetchApiData(selectedBankType: String, reference: String, storagePath: String, completion: @escaping ([TenantPaymentData]?, Error?) -> Void)
    func uploadFile(url: Data?, bankType: String, completion: @escaping (String?, Error?) -> Void)
    func setUpStoragePath(_ selectedBankType: String) -> String 
}

protocol APIDataHandler {
    func setUpApiData(with results: [TenantPaymentData]?) -> [TenantData]
    func filterAllPayments(tenants: [TenantPaymentData]) -> [TenantPaymentData]
    func setUpPaymentData(data: [TenantPaymentData]) -> [TenantData]
    func isPaymentComplete(amount: String) -> Bool
    func setUpHistoryData(with data: [TenantData]) -> History
    func setUpReferences() -> [String]
}

class ApiDataManager: ObservableObject, APIManager {
    let repository: RealmRepository
    let networkingManager = NetworkManagerConcreation()
//    let firebaseRepository = FirebaseRepository()
    
    var baseURL = "http://192.168.1.43:5000/api/fetchingAndReturning?"
    var storagePath = ""
    
    @Published var isCompletePayment = true
    var allHistoryData: [History] = []

    @Published var hasError: Bool = false
    @Published var error: ApiError?
    
    init(repository: RealmRepository) {
        self.repository = repository
    }
    
    func fetchApiData(selectedBankType: String, reference: String, storagePath: String, completion: @escaping ([TenantPaymentData]?, Error?) -> Void) {
        let url = networkingManager.createURL(
            baseURL: baseURL,
            parameters: [
                ("bankType", selectedBankType),
                ("referenceName", reference),
                ("storagePath", storagePath)
            ]
        )
        
        if let url = url {
            networkingManager.fetchData(from: url) { [weak self] (result: Result<[TenantPaymentData], ApiError>) in
                switch result {
                case .success(let data):
                    completion(data, nil)
                    os_log("API called successfully")
                case .failure(let error):
                    os_log("%@", type: .debug, self?.networkingManager.error.debugDescription ?? "")
                    self?.hasError = self?.networkingManager.hasError ?? true
                    self?.error = error
                    completion(nil, error)
                }
            }
        } else {
            os_log("Invalid URL")
            completion(nil, ApiError.invalidUrl)
        }
    }
    
    func uploadFile(url: Data?, bankType: String, completion: @escaping (String?, Error?) -> Void) {
        guard let localFile = url else { return }
        let fileStoragePath = setUpStoragePath(bankType)
//        firebaseRepository.uploadFile(url: url, fileStoragePath: fileStoragePath) { message, error in
//            if let error = error {
//                completion(nil, error)
//            }
//            completion(fileStoragePath, nil)
//        }
    }
    
    internal func setUpStoragePath(_ selectedBankType: String) -> String {
        let date = Date.now
        let day = date.formatted(.dateTime.weekday(.twoDigits))
        let month = date.formatted(.dateTime.month(.twoDigits))
        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
        return "statements/userID/\(day)_\(month)_\(year)_\(selectedBankType)_statement.pdf"
    }
}

import Foundation
import SwiftData
import OSLog

class ApiDataManager: ObservableObject {
    let modelContext: ModelContext
    let dataProvider: HistoryDataProvider
    let networkingManager = NetworkManagerConcreation()
    
    let baseURL = "http://192.168.1.43:5000/api/fetchingAndReturning?"
    let reference = "Salary Transfer"
    var selectedBankType = ""
    var storagePath = ""
    @Published var isCompletePayment = true
    @Published var allHistoryData: [History] = []
    @Published var shouldShowResultView: Bool = false
    
    @Published var isLoading = false
    @Published var hasError: Bool = false
    @Published var error: ApiError?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = HistoryDataProvider(modelContext: modelContext)
        self.allHistoryData = dataProvider.fetchData()
    }
    
    func fetchApiData(storagePath: String) {
        isLoading = true
        
        if let url = networkingManager.createURL(baseURL: baseURL, parameters: ["bankType": selectedBankType, "referenceName": reference, "storagePath": storagePath]) {
            networkingManager.fetchData(from: url) { [weak self] (result: Result<[TenantPaymentData], ApiError>) in
                switch result {
                case .success(let data):
                    self?.persistHistoryData(with: data)
                    self?.isLoading = false
                    self?.shouldShowResultView = true
                    os_log("API called successfully")
                case .failure(let error):
                    self?.isLoading = false
                    os_log("%@", type: .debug, self?.networkingManager.error.debugDescription ?? "")
                    self?.hasError = self?.networkingManager.hasError ?? true
                    self?.error = error
                }
            }
        } else {
            isLoading = false
            os_log("Invalid URL")
        }
    }
    
    func setUpApiData(with results: [TenantPaymentData]?) -> [TenantData] {
        if let results = results {
            let filteredData = filterAllPayments(tenants: results)
            let paymentData = setUpPaymentData(data: filteredData)
            return paymentData
        }
        return []
    }
    
    private func filterAllPayments(tenants: [TenantPaymentData]) -> [TenantPaymentData] {
        var updatedResult: [TenantPaymentData] = []
        
        for (index, tenant) in tenants.enumerated() {
            tenants[index].amount = tenant.amount.replacingOccurrences(of: "\"", with: "")
            updatedResult.append(tenants[index])
        }
        
        return updatedResult
    }
    
    func isPaymentComplete(amount: String) -> Bool {
        guard let amount = Double(amount) else { return false }
        
        if amount > 600 {
            return true
        } else {
            return false
        }
    }
    
    func setUpPaymentData(data: [TenantPaymentData]) -> [TenantData] {
        let results = data.map { data in
            TenantData(id: data.id, date: data.date, reference: data.reference, amount: data.amount)
        }
        
        return results
    }
    
    func setUpHistoryData(with data: [TenantData]) -> History {
        let date = Date.now
        return History(results: data, dateCreated: date.formatted(date: .abbreviated, time: .omitted))
    }
    
    func persistHistoryData(with results: [TenantPaymentData]?) {
        let data = setUpApiData(with: results)
        let history = setUpHistoryData(with: data)
        dataProvider.create(history)
        self.allHistoryData = dataProvider.fetchData()
    }
}

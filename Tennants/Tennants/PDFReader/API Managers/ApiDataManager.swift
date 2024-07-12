import Foundation
import SwiftData

class ApiDataManager: ObservableObject {
    let modelContext: ModelContext
    let dataProvider: HistoryDataProvider
    let networkingManager = NetworkManagerConcreation()
    
    let reference = "STANSAL"
    @Published var isCompletePayment = true
    @Published var allHistoryData: [History] = []
    @Published var shouldShowResultView: Bool = false
    
    @Published var isLoading = false
    @Published var hasError: Bool = false
    @Published var error: TenantError?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = HistoryDataProvider(modelContext: modelContext)
        self.allHistoryData = dataProvider.fetchData()
    }
    
    func fetchApiData(selectedBankType: String, storagePath: String) {
       isLoading = true
        let url = networkingManager.setUpURL(bankType: selectedBankType, 
                                             reference: reference,
                                             storagePath: storagePath)
        
        networkingManager.fetchUserData(apiURL: url) { [weak self] tenants in
            self?.persistHistoryData(with: tenants)
            self?.isLoading = false
            self?.shouldShowResultView = true
            print("API called successfully")
        }
        
        hasError = networkingManager.hasError
        error = networkingManager.error
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

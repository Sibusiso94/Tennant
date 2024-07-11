import Foundation
import SwiftData

class ApiDataManager: ObservableObject {
    let modelContext: ModelContext
    let dataProvider: DataProvider
    let networkingManager = NetworkManagerConcreation()
    
    let reference = "STANSAL"
    @Published var isCompletePayment = true
    @Published var results: [TenantPaymentData]?
    @Published var allHistoryData: [History] = []
    @Published var shouldShowResultView: Bool = false
    
    @Published var isLoading = false
    @Published var hasError: Bool = false
    @Published var error: TenantError?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = DataProvider(modelContext: modelContext)
        self.allHistoryData = dataProvider.fetchData()
    }
    
    func fetchApiData(selectedBankType: String, storagePath: String) {
       isLoading = true
        let url = networkingManager.setUpURL(bankType: selectedBankType, 
                                             reference: reference,
                                             storagePath: storagePath)
        
        networkingManager.fetchUserData(apiURL: url) { [weak self] tenants in
            self?.results = tenants
            self?.filterAllPayments(tenants: self?.results)
            
            self?.isLoading = false
            self?.shouldShowResultView = true
            print("API called successfully")
        }
        
        hasError = networkingManager.hasError
        error = networkingManager.error
    }
    
    private func filterAllPayments(tenants: [TenantPaymentData]?) {
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
    
    func setUpPaymentData(data: [TenantPaymentData]) -> [TenantData] {
        let results = data.map { data in
            TenantData(id: data.id, date: data.date, reference: data.reference, amount: data.amount)
        }
        
        return results
    }
}

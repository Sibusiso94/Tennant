import Foundation

protocol HistoryManagable {
    func fetchHistoryData() -> [History]
}

class HistoryManager: HistoryManagable {
    let repository: SwiftDataRepository
    let dataProvider: HistoryDataProvider
    let tenantPaymentDataProvider: TenantPaymentDataProvider

    init(repository: SwiftDataRepository) {
        self.repository = repository
        self.dataProvider = HistoryDataProvider(repository: repository)
        self.tenantPaymentDataProvider = TenantPaymentDataProvider(repository: repository)
    }
    
    func fetchHistoryData() -> [History] {
        dataProvider.fetchData()
    }

    func persistHistoryData(with results: [TenantPaymentData]?) {
        #warning("Add Group to wait for completion of each task")
        let historyId = UUID().uuidString
        let data = setUpApiData(with: results, id: historyId)
        let history = setUpHistoryData(with: data, id: historyId)
        dataProvider.create(history)
    }

    

    func getIds(_ data: [TenantData]) -> [String] {
        return data.map({ $0.id })
    }

    private func setUpHistoryData(with data: [TenantData], id: String) -> History {
        let date = Date.now
        let history = History()
        history.id = id
        history.results = getIds(data)
        history.dateCreated = date.formatted(date: .abbreviated, time: .omitted)
        return history
    }
    
    private func setUpApiData(with results: [TenantPaymentData]?, id: String) -> [TenantData] {
        if let results = results {
            let filteredData = filterAllPayments(tenants: results)
            let paymentData = setUpPaymentData(data: filteredData, id: id)
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
    
    private func setUpPaymentData(data: [TenantPaymentData], id: String) -> [TenantData] {
        let results = data.map { data in
            let newID = UUID().uuidString
            return TenantData(id: newID, historyId: id, date: data.date, reference: data.reference, amount: data.amount)
        }
        
        return results
    }
}

import Foundation
import RealmSwift

protocol HistoryManagable {
    func fetchData() -> [History]
    func persistHistoryData(with results: [TenantPaymentData]?)
}

protocol HistoryDataSetter {
    func setUpHistoryData(with data: [TenantData], id: String) -> History
    func filterAllPayments(tenants: [TenantPaymentData]) -> [TenantPaymentData]
    func setUpPaymentData(data: [TenantPaymentData], id: String) -> [TenantData]
}

class HistoryManager: HistoryManagable, HistoryDataSetter {
    let repository: RealmRepository
    let dataProvider: HistoryDataProvider
    let tenantDataProvider: TenantDataProvider
    let tenantPaymentDataProvider: TenantPaymentDataProvider

    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = HistoryDataProvider(repository: repository)
        self.tenantDataProvider = TenantDataProvider(repository: repository)
        self.tenantPaymentDataProvider = TenantPaymentDataProvider(repository: repository)
    }
    
    func fetchData() -> [History] {
        dataProvider.fetchData()
    }

    func fetchTenantData() -> [TenantData] {
        return tenantPaymentDataProvider.fetchData()
    }

    func persistHistoryData(with results: [TenantPaymentData]?) {
        #warning("Add Group to wait for completion of each task")
        let historyId = UUID().uuidString
        let data = setUpApiData(with: results, id: historyId)
        persistTenantData(data)
        let history = setUpHistoryData(with: data, id: historyId)
        dataProvider.create(history)
    }

    func persistTenantData(_ data: [TenantData]) {
        tenantPaymentDataProvider.createMultiple(data)
    }

    func getIds(_ data: [TenantData]) -> List<String> {
        let filteredData = data.map({ $0.id })
        let mappedResults = repository.mapResults(with: filteredData)
        return mappedResults
    }

    internal func setUpHistoryData(with data: [TenantData], id: String) -> History {
        let date = Date.now
        let history = History()
        history.id = id
        history.results = getIds(data)
        history.dateCreated = date.formatted(date: .abbreviated, time: .omitted)
        return history
    }
    
    internal func setUpApiData(with results: [TenantPaymentData]?, id: String) -> [TenantData] {
        if let results = results {
            let filteredData = filterAllPayments(tenants: results)
            let paymentData = setUpPaymentData(data: filteredData, id: id)
            return paymentData
        }
        
        return []
    }
    
    internal func filterAllPayments(tenants: [TenantPaymentData]) -> [TenantPaymentData] {
        var updatedResult: [TenantPaymentData] = []
        
        for (index, tenant) in tenants.enumerated() {
            tenants[index].amount = tenant.amount.replacingOccurrences(of: "\"", with: "")
            updatedResult.append(tenants[index])
        }
        
        return updatedResult
    }
    
    internal func setUpPaymentData(data: [TenantPaymentData], id: String) -> [TenantData] {
        let results = data.map { data in
            let newID = UUID().uuidString
            return TenantData(id: newID, historyId: id, date: data.date, reference: data.reference, amount: data.amount)
        }
        
        return results
    }
}

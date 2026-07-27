import Foundation

class HistoryManager: HistoryManagable {
    let repository: DataSource

    init(repository: DataSource) {
        self.repository = repository
    }
    
    func fetchHistoryData() -> [History] {
        repository.readAll(History.self)
    }

    func persistHistoryData(with results: [TenantPaymentData]?) async throws {
        let historyId = UUID().uuidString
        let data = setUpApiData(with: results, id: historyId)
        let history = setUpHistoryData(with: data, id: historyId)
        
        do {
            try repository.create(history)
        } catch {
            throw error
        }
    }

    private func getIds(_ data: [TenantData]) -> [String] {
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
        return tenants.map { tenant in
            var updated = tenant
            updated.amount = tenant.amount.replacingOccurrences(of: "\"", with: "")
            return updated
        }
    }
    
    private func setUpPaymentData(data: [TenantPaymentData], id: String) -> [TenantData] {
        let results = data.map { data in
            let newID = UUID().uuidString
            return TenantData(id: newID, historyId: id, date: data.date, reference: data.reference, amount: data.amount)
        }
        
        return results
    }
}

protocol HistoryManagable {
    func fetchHistoryData() -> [History]
    func persistHistoryData(with results: [TenantPaymentData]?) async throws
}

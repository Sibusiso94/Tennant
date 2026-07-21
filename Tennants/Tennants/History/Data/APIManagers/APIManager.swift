protocol APIManager {
    func fetchApiData(selectedBankType: String, userId: String, storagePath: String) async throws -> [TenantPaymentData]
}

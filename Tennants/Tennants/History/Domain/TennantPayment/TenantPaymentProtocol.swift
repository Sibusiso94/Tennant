import Foundation

protocol TenantPaymentProtocol {
    func getPaymentData(
        selectedBankType: String,
        userId: String
    ) async throws -> [TenantPaymentData]

    func handleImportedFile(
        url: URL,
        selectedBankType: String,
        userId: String
    ) async throws
}

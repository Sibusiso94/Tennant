import Foundation

protocol SupabaseNetworkingProtocol {
    func createReference(unitId: String, tenantId: String, reference: String/*, userID: UUID*/) async throws
    func uploadFile(fileData: Data, storagePath: String, selectedBankType: String) async throws
    func signUp() async throws
    func signIn() async throws
    func signOut() async throws
    func isUserAuthenticated() async
    func authorise() async throws
}

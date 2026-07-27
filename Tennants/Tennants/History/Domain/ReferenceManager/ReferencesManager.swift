import Foundation

class ReferencesManager: ReferencesManagable {
    private let supabaseRepository: SupabaseNetworkingProtocol

    init(supabaseRepository: SupabaseNetworkingProtocol) {
        self.supabaseRepository = supabaseRepository
    }

    func uploadReference(unitId: String, tenantId: String, reference: String) async throws {
        do {
            try await supabaseRepository.signIn()
            try await supabaseRepository.createReference(unitId: unitId, tenantId: tenantId, reference: reference)
        } catch {
            print("failed")
            print(error)
        }
    }
}

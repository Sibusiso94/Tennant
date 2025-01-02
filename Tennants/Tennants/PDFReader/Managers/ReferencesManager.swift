import Foundation

class ReferencesManager {
    private let supabaseRepository = SupabaseNetworking()
    
    func uploadReference(unitId: String, tenantId: String, reference: String) async throws {
        try? await supabaseRepository.signIn()
        do {
            try? await supabaseRepository.createReference(unitId: unitId, tenantId: tenantId, reference: reference)
        } catch {
            print("failed")
            print(error)
        }
    }
}

import Foundation

class ReferencesManager {
//    let repository: RealmRepository
    private let supabaseRepository = SupabaseNetworking()
//    private let dataProvider: TenantDataProvider
//    
//    init(repository: RealmRepository) {
//        self.repository = repository
//        self.dataProvider = TenantDataProvider(repository: repository)
//    }
    
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

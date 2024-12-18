import Foundation

class ReferencesManager {
    let repository: RealmRepository
    let supabaseRepository: SupabaseNetworking
    private let dataProvider: TenantDataProvider
    
    init(repository: RealmRepository,
         supabaseRepository: SupabaseNetworking) {
        self.repository = repository
        self.supabaseRepository = supabaseRepository
        self.dataProvider = TenantDataProvider(repository: repository)
    }
    
    private func fetchReferences() -> [String] {
        var references = [String]()
        let allTenants = dataProvider.fetchData()
        
        references = allTenants.map({ $0.reference })
        return references
    }
    
    func uploadReferences() async throws {
        let references = fetchReferences()
        try? await supabaseRepository.signIn()
        do {
            try? await supabaseRepository.createReference()
        } catch {
            print("failed")
            print(error)
        }
    }
}

import Foundation

class ReferencesManager {
    private let repository: RealmRepository
    private let firebaseRepository: FirebaseRepository
    private let dataProvider: TenantDataProvider
    
    init(repository: RealmRepository,
         firebaseRepository: FirebaseRepository) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
        self.dataProvider = TenantDataProvider(repository: repository)
    }
    
    func fetchReferences(completion: ([Reference]) -> Void) {
        var references = [Reference]()
        let allTenants = dataProvider.fetchData()
        
        references = allTenants.map({ tenant in
            return Reference(id: tenant.id, references: tenant.reference)
        })
        
        completion(references)
    }
    
    func uploadReferences(completion: (Result<Void, any Error>) -> Void) {
        fetchReferences { references in
            firebaseRepository.create(references) { result in
                completion(result)
            }
        }
    }
}

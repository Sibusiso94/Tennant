import Foundation

class ReferencesManager {
    let repository: RealmRepository
    let firebaseRepository: FirebaseRepository
    private let dataProvider: TenantDataProvider
    
    init(repository: RealmRepository,
         firebaseRepository: FirebaseRepository) {
        self.repository = repository
        self.firebaseRepository = firebaseRepository
        self.dataProvider = TenantDataProvider(repository: repository)
    }
    
    private func fetchReferences() -> Reference {
        var references = [String]()
        let allTenants = dataProvider.fetchData()
        
        references = allTenants.map({ $0.reference })
        return Reference(references: references)
    }
    
    func uploadReferences(completion: @escaping (Error?) -> Void) async {
        let references = fetchReferences()
        await firebaseRepository.create(references) { result in
            completion(result)
        }
    }
}

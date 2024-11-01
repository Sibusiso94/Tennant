
import Foundation

class TenantDataProvider: DataSource {
    typealias T = Tennant
    
    let repository: RealmRepository
    
    init(repository: RealmRepository) {
        self.repository = repository
    }
    
    func create(_ object: T) {
        do {
            try repository.create(object)
        } catch let error {
            
        }
    }

    func fetchData() -> [T] {
//        let descriptor = FetchDescriptor<T>()
        let data = repository.readAll(T.self)
        return data
    }
    
    func fetchData(by id: String) -> Tennant? {
        let allTenants = fetchData()
        if let tenantToReturn = allTenants.first(where: { $0.id == id }) {
            return tenantToReturn
        }
        
        return nil
    }
    
    func update(_ object: T) {
        do {
            try repository.update(object)
        } catch let error {
            
        }
    }
    
    func delete(_ id: String) {
        do {
            try repository.delete(id, ofType: T.self)
        } catch let error {
            
        }
    }
}


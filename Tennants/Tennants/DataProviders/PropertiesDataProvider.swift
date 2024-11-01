import Foundation
import RealmSwift

class PropertiesDataProvider: DataSource {
    typealias T = Property
    
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
//        let descriptor = FetchDescriptor<T>(sortBy: [SortDescriptor(\.buildingName)])
        let data = repository.readAll(T.self)
        return data
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

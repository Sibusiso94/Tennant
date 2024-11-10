import Foundation
import RealmSwift

class UnitsDataProvider: DataSource {
    typealias T = SingleUnit
    
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
    
    func createMultiple(_ object: [T]) {
        do {
            try repository.createMultiple(object)
        } catch let error {
            
        }
    }
    
    func fetchData() -> [T] {
//        let descriptor = FetchDescriptor<T>(sortBy: [SortDescriptor(\.unitNumber, order: .forward)])
        let data = repository.readAll(T.self)
        return data
    }
    
    func update(id: String,
                tenantId: String? = nil,
                numberOfBedrooms: Int? = nil,
                numberOfBathrooms: Int? = nil,
                size: Int? = nil) {
        let realm = try! Realm()
        
        if let unitToUpdate = realm.object(ofType: SingleUnit.self, forPrimaryKey: id) {
            try! realm.write {
                if let tenantId {
                    unitToUpdate.tenantID = tenantId
                    unitToUpdate.isOccupied = true
                }
                
                if let numberOfBedrooms {
                    unitToUpdate.numberOfBedrooms = numberOfBedrooms
                }
                
                if let numberOfBathrooms {
                    unitToUpdate.numberOfBathrooms = numberOfBathrooms
                }
                
                if let size {
                    unitToUpdate.size = size
                }
            }
        } else {
            print("Unit not found")
        }
    }
    
    func delete(_ id: String) {
        do {
            try repository.delete(id, ofType: T.self)
        } catch let error {
            
        }
    }
}

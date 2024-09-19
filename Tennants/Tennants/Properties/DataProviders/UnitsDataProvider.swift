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
                isOccupied: Bool? = nil) {
        let realm = try! Realm()
        
        if let unitToUpdate = realm.object(ofType: SingleUnit.self, forPrimaryKey: id) {
            try! realm.write {
                if let tenantId = tenantId {
                    unitToUpdate.tenantID = tenantId
                    unitToUpdate.isOccupied = true
                }
                
                if let numberOfBedrooms = numberOfBedrooms {
                    unitToUpdate.numberOfBedrooms = numberOfBedrooms
                }
                
                if let numberOfBathrooms = numberOfBathrooms {
                    unitToUpdate.numberOfBathrooms = numberOfBathrooms
                }
                
                if let isOccupied = isOccupied {
                    unitToUpdate.isOccupied = true
                }
            }
        } else {
            print("Unit not found")
        }
    }
    
    func delete(_ object: T) {
        do {
            try repository.delete(object)
        } catch let error {
            
        }
    }
}

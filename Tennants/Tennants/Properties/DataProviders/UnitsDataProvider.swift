import Foundation

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
    
    func update(_ object: T) {
        do {
            try repository.update(insertions: [object])
        } catch let error {
            
        }
    }
    
    func delete(_ object: T) {
        do {
            try repository.delete(object)
        } catch let error {
            
        }
    }
}

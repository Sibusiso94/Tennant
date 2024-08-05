import Foundation
import SwiftData

class UnitsDataProvider: SwiftDataSource {
    typealias T = SingleUnit
    
    let modelContext: ModelContext
    let repository: SwiftDataRepository
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.repository = SwiftDataRepository(modelContext: modelContext)
    }
    
    func create(_ object: T) {
        repository.create(data: object)
    }
    
    func createMultiple(_ object: [T]) {
        repository.createMultiple(data: object)
    }
    
    func fetchData() -> [T] {
        let descriptor = FetchDescriptor<T>(sortBy: [SortDescriptor(\.unitNumber)])
        return repository.read(request: descriptor)
    }
    
    func update(_ object: T) {
        repository.update(object: object)
    }
    
    func delete(_ object: T) {
        repository.delete(object: object)
    }
}

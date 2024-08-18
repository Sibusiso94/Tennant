
import Foundation
import SwiftData

class TenantDataProvider: SwiftDataSource {
    typealias T = Tennant
    
    let modelContext: ModelContext
    let repository: SwiftDataRepository
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.repository = SwiftDataRepository(modelContext: modelContext)
    }
    
    func create(_ object: T) {
        repository.create(data: object)
    }
    
    func fetchData() -> [T] {
        let descriptor = FetchDescriptor<T>()
        return repository.read(request: descriptor)
    }
    
    func update(_ object: T) {
        repository.update(object: object)
    }
    
    func delete(_ object: T) {
        repository.delete(object: object)
    }
}


import Foundation
import SwiftData

class DataProvider: DataSource {
    typealias T = History
    
    let modelContext: ModelContext
    let repository: SwiftDataRepository
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.repository = SwiftDataRepository(modelContext: modelContext)
    }
    
    func create(_ object: History) {
        repository.create(data: object)
    }
    
    func fetchData() -> [History] {
        let descriptor = FetchDescriptor<History>(sortBy: [SortDescriptor(\.dateCreated)])
        return repository.read(request: descriptor)
    }
    
    func update(_ object: History) {
        repository.update(object: object)
    }
    
    func delete(_ object: History) {
        repository.delete(object: object)
    }
}

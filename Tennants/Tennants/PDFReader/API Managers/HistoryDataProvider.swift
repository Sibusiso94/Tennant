import Foundation
import SwiftData

class HistoryDataProvider: CreateSD, ReadSD {
    typealias T = History
    
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
        let descriptor = FetchDescriptor<T>(sortBy: [SortDescriptor(\.dateCreated)])
        return repository.read(request: descriptor)
    }
    
    func delete(_ object: T) {
        repository.delete(object: object)
    }
}

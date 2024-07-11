import Foundation
import SwiftData

protocol DataSource {
    associatedtype T: PersistentModel
    
    func create(_ object: T)
//    func read<T: PersistentModel>(request: FetchDescriptor<T>) -> [T]
    func fetchData() -> [T]
    func update(_ object: T)
    func delete(_ object: T)
}

@Observable
class SwiftDataRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func create<T: PersistentModel>(data: T) {
        modelContext.insert(data)
    }
    
    func read<T: PersistentModel>(request: FetchDescriptor<T>) -> [T] {
        do {
            return try modelContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func update<T: PersistentModel>(object: T) {
        do {
            try modelContext.save()
        } catch {
            print("Failed to update")
        }
    }
    
    func delete<T: PersistentModel>(object: T) {
        do {
            modelContext.delete(object)
            try modelContext.save()
        } catch {
            
        }
    }
}

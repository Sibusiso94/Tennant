import Foundation
import SwiftData

class HistoryDataProvider: CreateObject, ReadObject, DeleteObject {
    typealias T = History
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
        let data = repository.readAll(T.self)
        return data
    }
    
    func delete(_ object: T) {
        do {
            try repository.delete(object)
        } catch let error {
            
        }
    }
}

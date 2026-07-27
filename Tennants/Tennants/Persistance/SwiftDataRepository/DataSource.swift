import SwiftData

protocol DataSource: CreateObject, ReadObject, UpdateObject, DeleteObject { }

protocol CreateObject {
    func create<T: PersistableModel>(_ insertion: T) throws
    func createMultiple<T: PersistableModel>(_ insertions: [T]) throws
}

protocol ReadObject {
    func readAll<T: PersistableModel>(_ type: T.Type) -> [T]
}

protocol UpdateObject {
    func update<T: PersistableModel>(_ object: T) throws
}

protocol DeleteObject {
    func delete<T: PersistableModel>(_ id: String, ofType type: T.Type) throws
    func deleteAll<T: PersistableModel>(_ objects: [T]) throws
}

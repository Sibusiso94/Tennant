import Foundation
import SwiftData

protocol DataSource: CreateObject, ReadObject, DeleteObject { }

protocol CreateObject {
    associatedtype T: PersistableModel
    func create(_ object: T)
}

protocol MultipleObjectsCreatable {
    associatedtype T: PersistableModel
    func createMultiple(_ insertions: [T])
}

protocol ReadObject {
    associatedtype T: PersistableModel
    func fetchData() -> [T]
}

protocol UpdateObject {
    associatedtype T: AnyObject
    func update(deletingSpecifically: T, insertions: T)
}

protocol DeleteObject {
    associatedtype T: PersistableModel
    func delete(_ id: String)
}

/// A SwiftData-backed model that exposes its primary key as a `String` so the
/// repository can offer generic, key-based reads and deletes.
protocol PersistableModel: PersistentModel {
    var primaryKey: String { get }
}

class SwiftDataRepository {
    /// All persisted model types live in a single shared container so that every
    /// repository instance reads and writes the same underlying store.
    static let sharedContainer: ModelContainer = {
        let schema = Schema([
            Tennant.self,
            Property.self,
            SingleUnit.self,
            History.self,
            TenantData.self
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    let container: ModelContainer
    let context: ModelContext

    public init() {
        self.container = SwiftDataRepository.sharedContainer
        self.context = ModelContext(container)
    }

    func create<T: PersistableModel>(_ insertion: T) throws {
        context.insert(insertion)
        try context.save()
    }

    func createMultiple<T: PersistableModel>(_ insertions: [T]) throws {
        for insertion in insertions {
            context.insert(insertion)
        }
        try context.save()
    }

    public func read<T: PersistableModel>(_ type: T.Type) -> T? {
        return readAll(type).first
    }

    public func readAll<T: PersistableModel>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>()
        do {
            return try context.fetch(descriptor)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    public func update<T: PersistableModel>(_ object: T) throws {
        // SwiftData performs an upsert when inserting a model whose unique
        // attribute matches an existing record, mirroring Realm's `.modified`.
        context.insert(object)
        try context.save()
    }

    public func delete<T: PersistableModel>(_ id: String, ofType type: T.Type) throws {
        guard let objectToDelete = readAll(type).first(where: { $0.primaryKey == id }) else {
            print("Object not found")
            return
        }

        context.delete(objectToDelete)
        try context.save()
    }

    public func deleteAll<T: PersistableModel>(_ objects: [T]) throws {
        for object in objects {
            context.delete(object)
        }
        try context.save()
    }

    public func clearStore() {
        do {
            try context.delete(model: Tennant.self)
            try context.delete(model: Property.self)
            try context.delete(model: SingleUnit.self)
            try context.delete(model: History.self)
            try context.delete(model: TenantData.self)
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

import Foundation
import RealmSwift

protocol DataSource {
    associatedtype T: Object
    
    func create(_ object: T)
//    func fetchData() -> [T]
    func update(deletingSpecifically: T, insertions: T)
    func delete(_ object: T)
}

protocol CreateObject {
    associatedtype T: Object
    func create(_ object: T)
}

protocol ReadObject {
    associatedtype T: Object
    func fetchData() -> [T]
}

protocol UpdateObject {
    associatedtype T: AnyObject
    func update(deletingSpecifically: T, insertions: T)
}

protocol DeleteObject {
    associatedtype T: Object
    func delete(_ object: T)
}

public typealias RealmDecodable = Object & Decodable
public typealias RealmCodable = Object & Codable

fileprivate func getConfiguration(fileName: String) -> Realm.Configuration {
    var configuration = Realm.Configuration.defaultConfiguration
    configuration.fileURL = configuration.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
    return configuration
}

class RealmRepository {
    private var configuration: Realm.Configuration
    
    public init() {
        let configuration = getConfiguration(fileName: "tenant.realm")
        Realm.Configuration.defaultConfiguration = configuration
        
        self.configuration = configuration
        
        initializeRealm()
    }
    
    private func initializeRealm() {
        do {
            _ = try Realm(configuration: configuration)
        } catch let error {
            print(error.localizedDescription)
            deleteRealm()
        }
    }
    
    public var realm: Realm {
        return try! Realm()
    }
    
    func create(_ insertions: Object) throws {
        try transaction { realm in
            realm.add(insertions)
        }
    }
    
    func createMultiple(_ insertions: [Object]) throws {
        try transaction { realm in
            realm.add(insertions)
        }
    }

    public func read<T: Object>(_ type: T.Type) -> T? {
        return readAll(type).first
    }
    
    public func readAll<T: Object>(_ type: T.Type) -> [T] {
        return Array(realm.objects(type))
    }
    
    public func update(deletions: [AnyClass] = [], insertions: [AnyObject] = []) throws {
        try transaction { realm in
            let deletions = deletions.compactMap {
                $0 as? Object.Type
            }
            let insertions = insertions.compactMap {
                $0 as? Object
            }
            deletions.forEach {
                realm.delete(realm.objects($0))
            }
            realm.add(insertions)
        }
    }
    
    public func update(deletingSpecifically: [AnyObject] = [], insertions: [AnyObject] = []) throws {
        try transaction { realm in
            let insertions = insertions.compactMap {
                $0 as? Object
            }
            let deletions = deletingSpecifically.compactMap {
                $0 as? Object
            }
            realm.delete(deletions)
            realm.add(insertions)
        }
    }
    
    public func delete(_ object: Object) throws {
        try transaction { realm in
            realm.delete(object)
        }
    }
    
    public func deleteAll(_ objects: [AnyObject]) throws {
        try transaction { realm in
            let deletions = objects.compactMap {
                $0 as? Object
            }
            deletions.forEach { item in
                realm.delete(item)
            }
        }
    }
    
    private func transaction(block: ((Realm) throws -> Void)) throws {
        do {
            let realm = self.realm
            realm.beginWrite()
            do {
                try block(realm)
            } catch {
                if realm.isInWriteTransaction {
                    realm.cancelWrite()
                }
                throw error
            }
            if realm.isInWriteTransaction {
                try realm.commitWrite()
            }
        } catch let error {
            print("Transaction error: \(error.localizedDescription)")
            throw error
        }
    }
    
    public func clearRealm() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func deleteRealm() {
        guard let realmURL = configuration.fileURL else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: realmURL)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func convertListToResult<T>(with results: List<T>) -> [T] {
        var data = [T]()
        
        for result in results {
            data.append(result)
        }
        
        return data
    }
    
    func mapResults<T>(with results: [T]) -> List<T> {
        var data = List<T>()
        
        for result in results {
            data.append(result)
        }
        
        return data
    }
}


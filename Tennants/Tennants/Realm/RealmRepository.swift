import Foundation
import Foundation
import RealmSwift

public typealias RealmDecodable = Object & Decodable
public typealias RealmCodable = Object & Codable

fileprivate func getConfiguration(fileName: String) -> Realm.Configuration {
    var configuration = Realm.Configuration.defaultConfiguration
    configuration.fileURL = configuration.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
    return configuration
}

class RealmRepository: ObservableObject {
    private var configuration: Realm.Configuration
    @ObservedResults(Tennant.self) var tennants
    
    public init() {
        let configuration = getConfiguration(fileName: "tennant.realm")
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
        return try! Realm(configuration: configuration)
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

    public func object<T: Object>(_ type: T.Type) -> T? {
        return objects(type).first
    }
    
    public func objects<T: Object>(_ type: T.Type) -> [T] {
        return Array(realm.objects(type))
    }
    
    public func add(_ tennant: Tennant) {
        do {
            let realm = try Realm()
            
            try realm.write {
                $tennants.append(tennant)
                realm.add(tennants, update: .modified)
            }
        } catch {
            print("Failed to add wish list item: \(error)")
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
    
    public func delete(_ object: Object) throws {
        try transaction { realm in
            realm.delete(object)
        }
    }
    
    public func update(insertions: [AnyObject] = []) throws {
        try transaction { realm in
            let insertions = insertions.compactMap {
                $0 as? Object
            }
            
            realm.add(insertions, update: .modified)
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
}


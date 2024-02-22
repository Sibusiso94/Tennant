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
    @ObservedResults(Property.self) var properties
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
    
    func mapPropertiesToArray() -> [Property] {
        return self.properties.map({ Property(buildingID: $0.buildingID,
                                                              buildingName: $0.buildingName,
                                                              buildingAddress: $0.buildingAddress,
                                                              numberOfUnits: $0.numberOfUnits,
                                                              numberOfUnitsOccupied: $0.numberOfUnitsOccupied,
                                                              flats: $0.flats) })
    }
    
    func mapTennantsToArray() -> [Tennant] {
        return self.tennants.map({ Tennant(buildingNumber: $0.buildingNumber,
                                                                  flatNumber: $0.flatNumber,
                                                                  tennantID: $0.tennantID,
                                                                  name: $0.name,
                                                                  surname: $0.surname,
                                                                  company: $0.company,
                                                                  position: $0.position,
                                                                  monthlyIncome: $0.monthlyIncome,
                                                                  balance: $0.balance,
                                                                  amountDue: $0.amountDue,
                                                                  startDate: $0.startDate,
                                                                  endDate: $0.endDate,
                                                                  fullPayments: $0.fullPayments) })
    }
}


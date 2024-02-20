import Foundation
import RealmSwift

class Property: Object, Identifiable {
    @Persisted(primaryKey: true) var buildingID: String
    @Persisted var isAHome: Bool
    @Persisted var buildingName: String
    @Persisted var buildingAddress: String
    @Persisted var numberOfUnits: String
    @Persisted var numberOfUnitsOccupied: String
    
    convenience init(isAHome: Bool = false,
                     buildingName: String,
                     buildingAddress: String,
                     numberOfUnits: String,
                     numberOfUnitsOccupied: String) {
        self.init()
        self.buildingID = UUID().uuidString
        self.isAHome = isAHome
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.numberOfUnitsOccupied = numberOfUnitsOccupied
    }
}

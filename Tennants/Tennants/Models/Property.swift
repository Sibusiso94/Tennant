import Foundation
import RealmSwift

class Property: Object, Identifiable {
    @Persisted(primaryKey: true) var buildingID: String
    @Persisted var isASingle: Bool
    @Persisted var buildingName: String
    @Persisted var buildingAddress: String
    @Persisted var numberOfUnits: String
    @Persisted var numberOfUnitsOccupied: String
    @Persisted var units: List<String>
    
    convenience init(buildingID: String,
                     isASingle: Bool = false,
                     buildingName: String,
                     buildingAddress: String,
                     numberOfUnits: String,
                     numberOfUnitsOccupied: String,
                     units: List<String> = List<String>()) {
        self.init()
        self.buildingID = UUID().uuidString
        self.isASingle = isASingle
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.numberOfUnitsOccupied = numberOfUnitsOccupied
        self.units = units
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

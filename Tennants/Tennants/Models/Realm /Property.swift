import Foundation
import RealmSwift

class Property: Object, Identifiable {
    @Persisted(primaryKey: true) var buildingID: String
    @Persisted var unitIDs: List<String>
    @Persisted var buildingName: String
    @Persisted var buildingAddress: String
    @Persisted var numberOfUnits: String
    @Persisted var isSingleUnit: Bool

    convenience init(buildingID: String = UUID().uuidString,
                     buildingName: String = "",
                     buildingAddress: String = "",
                     numberOfUnits: String = "",
                     unitIDs: List<String> = List<String>(),
                     isSingleUnit: Bool = true) {
        self.init()
        self.buildingID = buildingID
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.unitIDs = unitIDs
        self.isSingleUnit = isSingleUnit
    }

    override class func primaryKey() -> String? {
        "buildingID"
    }
}

//class MockProperties {
//    static let properties = [Property(buildingID: "T", buildingName: "Telesto", buildingAddress: "6 Pinotage Street", numberOfUnits: "10", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Honey Dew", buildingAddress: "6 Bee Street", numberOfUnits: "6", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Benoni", buildingAddress: "6 Voortrekker Street", numberOfUnits: "8", numberOfUnitsOccupied: "")]
//}

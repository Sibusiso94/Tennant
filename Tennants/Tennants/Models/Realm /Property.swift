import Foundation
import SwiftData

@Model
class Property: Identifiable, PersistableModel {
    @Attribute(.unique) var buildingID: String
    var unitIDs: [String]
    var buildingName: String
    var buildingAddress: String
    var numberOfUnits: String
    var isSingleUnit: Bool

    var id: String { buildingID }
    var primaryKey: String { buildingID }

    init(buildingID: String = UUID().uuidString,
         buildingName: String = "",
         buildingAddress: String = "",
         numberOfUnits: String = "",
         unitIDs: [String] = [],
         isSingleUnit: Bool = true) {
        self.buildingID = buildingID
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.unitIDs = unitIDs
        self.isSingleUnit = isSingleUnit
    }
}

//class MockProperties {
//    static let properties = [Property(buildingID: "T", buildingName: "Telesto", buildingAddress: "6 Pinotage Street", numberOfUnits: "10", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Honey Dew", buildingAddress: "6 Bee Street", numberOfUnits: "6", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Benoni", buildingAddress: "6 Voortrekker Street", numberOfUnits: "8", numberOfUnitsOccupied: "")]
//}

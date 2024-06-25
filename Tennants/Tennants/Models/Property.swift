import Foundation
import SwiftData

@Model
class Property {
    @Attribute(.unique) var buildingID: String
    var buildingName: String
    var buildingAddress: String
    var numberOfUnits: String
    var units: [String]
    var occupiedUnitIDs: [String]
    
    init(buildingID: String = UUID().uuidString,
         buildingName: String = "",
         buildingAddress: String = "",
         numberOfUnits: String = "",
         units: [String] = [],
         occupiedUnitIDs: [String] = []) {
        self.buildingID = buildingID
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.occupiedUnitIDs = occupiedUnitIDs
        self.units = units
    }
}

//class MockProperties {
//    static let properties = [Property(buildingID: "T", buildingName: "Telesto", buildingAddress: "6 Pinotage Street", numberOfUnits: "10", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Honey Dew", buildingAddress: "6 Bee Street", numberOfUnits: "6", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Benoni", buildingAddress: "6 Voortrekker Street", numberOfUnits: "8", numberOfUnitsOccupied: "")]
//}

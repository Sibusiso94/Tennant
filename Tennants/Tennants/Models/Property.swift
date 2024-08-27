import Foundation
import SwiftData

@Model
class Property {
    @Attribute(.unique) var buildingID: String
    @Relationship(deleteRule: .cascade) var units: [SingleUnit]
    var buildingName: String
    var buildingAddress: String
    var numberOfUnits: String
    
    init(buildingID: String = UUID().uuidString,
         buildingName: String = "",
         buildingAddress: String = "",
         numberOfUnits: String = "",
         units: [SingleUnit] = []) {
        self.buildingID = buildingID
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.units = units
    }
}

class TempProperty {
    var buildingID: String
    var units: [TempSingleUnit]
    var buildingName: String
    var buildingAddress: String
    var numberOfUnits: String
    
    init(buildingID: String = UUID().uuidString,
         buildingName: String = "",
         buildingAddress: String = "",
         numberOfUnits: String = "",
         units: [TempSingleUnit] = []) {
        self.buildingID = buildingID
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.units = units
    }
}

//class MockProperties {
//    static let properties = [Property(buildingID: "T", buildingName: "Telesto", buildingAddress: "6 Pinotage Street", numberOfUnits: "10", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Honey Dew", buildingAddress: "6 Bee Street", numberOfUnits: "6", numberOfUnitsOccupied: ""),
//                             Property(buildingID: "T", buildingName: "Benoni", buildingAddress: "6 Voortrekker Street", numberOfUnits: "8", numberOfUnitsOccupied: "")]
//}

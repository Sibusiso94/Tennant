import Foundation

class Property: Identifiable {
    var buildingID: String
    var isAHome: Bool
    var buildingName: String
    var buildingAddress: String
    var numberOfUnits: String
    var numberOfUnitsOccupied: String
    var units: [String]
    
    init(buildingID: String,
                     isAHome: Bool = false,
                     buildingName: String,
                     buildingAddress: String,
                     numberOfUnits: String,
                     numberOfUnitsOccupied: String,
                     units: [String] = []) {
        self.buildingID = UUID().uuidString
        self.isAHome = isAHome
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.numberOfUnitsOccupied = numberOfUnitsOccupied
        self.units = units
    }
}

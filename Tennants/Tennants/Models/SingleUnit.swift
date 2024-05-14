import Foundation

class SingleUnit: Identifiable  {
    var id: String
    var UnitNumber: Int
    var buildingID: String
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var isAvailable: Bool
    var tennantID: String
    
    init(id: String = UUID().uuidString,
                     unitNumber: Int,
                     buildingID: String,
                     numberOfBedrooms: Int,
                     numberOfBathrooms: Int,
                     isAvailable: Bool,
                     tennantID: String = "") {
        self.id = id
        self.UnitNumber = unitNumber
        self.buildingID = buildingID
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isAvailable = isAvailable
        self.tennantID = tennantID
    }
}

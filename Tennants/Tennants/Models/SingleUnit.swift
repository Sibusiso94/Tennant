import Foundation
import SwiftData

@Model
class SingleUnit: Identifiable  {
    @Attribute(.unique) var id: String
    var unitNumber: Int
    var buildingID: String
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var isAvailable: Bool
    var tennantID: String
    
    init(id: String = UUID().uuidString,
                     unitNumber: Int = 0,
                     buildingID: String = "",
                     numberOfBedrooms: Int = 1,
                     numberOfBathrooms: Int = 1,
                     isAvailable: Bool =  false,
                     tennantID: String = "") {
        self.id = id
        self.unitNumber = unitNumber
        self.buildingID = buildingID
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isAvailable = isAvailable
        self.tennantID = tennantID
    }
}

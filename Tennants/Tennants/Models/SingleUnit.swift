import Foundation
import SwiftData

@Model
class SingleUnit: Identifiable  {
    @Attribute(.unique) var id: String
    var unitNumber: Int
    var property: Property
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var tennantID: String?
    
    init(id: String = UUID().uuidString,
         unitNumber: Int = 0,
         property: Property = Property(),
         numberOfBedrooms: Int = 1,
         numberOfBathrooms: Int = 1,
         tennantID: String? = nil) {
        self.id = id
        self.unitNumber = unitNumber
        self.property = property
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.tennantID = tennantID
    }
}

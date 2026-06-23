import Foundation
import SwiftData

@Model
class SingleUnit: Identifiable, PersistableModel {
    @Attribute(.unique) var id: String
    var tenantID: String
    var unitNumber: Int
    var propertyId: String
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var size: Int
    var isOccupied: Bool

    var primaryKey: String { id }

    init(id: String = UUID().uuidString,
         unitNumber: Int = 0,
         propertyId: String = "",
         tenantID: String = "",
         numberOfBedrooms: Int = 1,
         numberOfBathrooms: Int = 1,
         size: Int = 0,
         isOccupied: Bool = false) {
        self.id = id
        self.unitNumber = unitNumber
        self.propertyId = propertyId
        self.tenantID = tenantID
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.size = size
        self.isOccupied = isOccupied
    }
}

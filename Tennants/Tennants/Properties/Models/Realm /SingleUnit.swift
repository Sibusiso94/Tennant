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
         unitNumber: Int,
         propertyId: String,
         tenantID: String,
         numberOfBedrooms: Int,
         numberOfBathrooms: Int,
         size: Int,
         isOccupied: Bool) {
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

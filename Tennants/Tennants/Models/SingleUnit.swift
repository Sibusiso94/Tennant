import Foundation
import RealmSwift

class SingleUnit: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var tenantID: String
    @Persisted var unitNumber: Int
    @Persisted var propertyId: String
    @Persisted var numberOfBedrooms: Int
    @Persisted var numberOfBathrooms: Int
    @Persisted var isOccupied: Bool
    
    convenience init(id: String = UUID().uuidString,
         unitNumber: Int = 0,
         propertyId: String = "",
         tenantID: String = "",
         numberOfBedrooms: Int = 1,
         numberOfBathrooms: Int = 1,
         isOccupied: Bool = false) {
        self.init()
        self.id = id
        self.unitNumber = unitNumber
        self.propertyId = propertyId
        self.tenantID = tenantID
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isOccupied = isOccupied
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

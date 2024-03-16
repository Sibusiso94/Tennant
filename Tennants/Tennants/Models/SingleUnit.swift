import Foundation
import RealmSwift

class SingleUnit: Object, Identifiable  {
    @Persisted(primaryKey: true) var id: String
    @Persisted var UnitNumber: Int
    @Persisted var buildingID: String
    @Persisted var numberOfBedrooms: Int
    @Persisted var numberOfBathrooms: Int
    @Persisted var isAvailable: Bool
    @Persisted var tennantID: String
    
    convenience init(id: String = UUID().uuidString, 
                     unitNumber: Int,
                     buildingID: String,
                     numberOfBedrooms: Int,
                     numberOfBathrooms: Int,
                     isAvailable: Bool,
                     tennantID: String = "") {
        self.init()
        self.id = id
        self.UnitNumber = unitNumber
        self.buildingID = buildingID
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isAvailable = isAvailable
        self.tennantID = tennantID
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

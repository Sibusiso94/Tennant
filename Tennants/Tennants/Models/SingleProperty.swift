import Foundation
import RealmSwift

class SingleProperty: Object, Identifiable  {
    @Persisted(primaryKey: true) var id: String
    @Persisted var propertyName: String
    @Persisted var numberOfBedrooms: Int
    @Persisted var numberOfBathrooms: Int
    @Persisted var tennantID: String
    
    convenience init(id: String = UUID().uuidString,
                     propertyName: String,
                     numberOfBedrooms: Int,
                     numberOfBathrooms: Int,
                     tennantID: String = "") {
        self.init()
        self.id = id
        self.propertyName = propertyName
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.tennantID = tennantID
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

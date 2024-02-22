import Foundation
import RealmSwift

class Flat: Object, Identifiable  {
    @Persisted(primaryKey: true) var id: String
    @Persisted var flatNumber: Int
    @Persisted var buildingID: String
    @Persisted var tennantID: String
    
    convenience init(id: String = UUID().uuidString, flatNumber: Int,
                     buildingID: String,
                     tennantID: String = "") {
        self.init()
        self.id = id
        self.flatNumber = flatNumber
        self.buildingID = buildingID
        self.tennantID = tennantID
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

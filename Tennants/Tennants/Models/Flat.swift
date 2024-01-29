import Foundation
import RealmSwift

class Flat: Object, Identifiable {
    @Persisted(primaryKey: true) var flatID: String
    @Persisted var buildingID: Int
    @Persisted var flatNumber: Int
    
    convenience init(flatID: String = UUID().uuidString,
                     buildingNumber: Int,
                     flatNumber: Int) {
        self.init()
        self.buildingID = buildingID
        self.flatNumber = flatNumber
    }
}

import Foundation
import RealmSwift

class Flat: Object, Identifiable {
    @Persisted(primaryKey: true) var flatID: String
    @Persisted var buildingID: Int
    @Persisted var numberOfFlatsOccupied: Int
    
    convenience init(flatID: String = UUID().uuidString,
                     buildingNumber: String,
                     numberOfFlatsOccupied: Int) {
        self.init()
        self.buildingID = buildingID
        self.numberOfFlatsOccupied = numberOfFlatsOccupied
    }
}

import Foundation
import RealmSwift

class Property: Object, Identifiable {
    @Persisted(primaryKey: true) var buildingID: String
    @Persisted var isAHome: Bool
    @Persisted var buildingName: String
    @Persisted var buildingAddress: String
    @Persisted var numberOfUnits: Int
    @Persisted var numberOfFlatsOccupied: Int
    
    convenience init(isAHome: Bool,
                     buildingName: String,
                     buildingAddress: String,
                     numberOfUnits: Int,
                     numberOfFlatsOccupied: Int) {
        self.init()
        self.isAHome = isAHome
        self.buildingName = buildingName
        self.buildingAddress = buildingAddress
        self.numberOfUnits = numberOfUnits
        self.numberOfFlatsOccupied = numberOfFlatsOccupied
    }
}

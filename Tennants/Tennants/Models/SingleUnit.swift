import Foundation
import SwiftData

@Model
class SingleUnit: Identifiable  {
    @Attribute(.unique) var id: String
    @Relationship(deleteRule: .cascade) var tenant: Tennant
    var unitNumber: Int
    var property: Property
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var isOccupied: Bool
    
    init(id: String = UUID().uuidString,
         unitNumber: Int = 0,
         property: Property = Property(),
         tenant: Tennant = Tennant(), 
         numberOfBedrooms: Int = 1,
         numberOfBathrooms: Int = 1,
         isOccupied: Bool = false) {
        self.id = id
        self.unitNumber = unitNumber
        self.property = property
        self.tenant = tenant
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isOccupied = isOccupied
    }
}

class TempSingleUnit: Identifiable  {
    var id: String
    var tenant: TempTennant
    var unitNumber: Int
    var property: TempProperty
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var isOccupied: Bool
    
    init(id: String = UUID().uuidString,
         unitNumber: Int = 0,
         property: TempProperty = TempProperty(),
         tenant: TempTennant = TempTennant(),
         numberOfBedrooms: Int = 1,
         numberOfBathrooms: Int = 1,
         isOccupied: Bool = false) {
        self.id = id
        self.unitNumber = unitNumber
        self.property = property
        self.tenant = tenant
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.isOccupied = isOccupied
    }
}

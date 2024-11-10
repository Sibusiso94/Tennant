import Foundation

class NewDataModel {
    var isAProperty: Bool
    var name: String
    var surname: String
    var tennantID: String
    var address: String
    var numberOfUnits: String
    var numberOfBedrooms: String
    var numberOfBathrooms: String
    var buildingNumber: String
    var unitID: String
    var company: String
    var position: String
    var monthlyIncome: String
    var size: String

    init(isAProperty: Bool = false,
         name: String = "",
         surname: String = "",
         tennantID: String = "",
         address: String = "",
         numberOfUnits: String = "",
         numberOfBedrooms: String = "",
         numberOfBathrooms: String = "",
         buildingNumber: String = "",
         unitID: String = "",
         company: String = "",
         position: String = "",
         monthlyIncome: String = "",
         size: String = "") {
        self.isAProperty = isAProperty
        self.name = name
        self.surname = surname
        self.tennantID = tennantID
        self.address = address
        self.numberOfUnits = numberOfUnits
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.buildingNumber = buildingNumber
        self.unitID = unitID
        self.company = company
        self.position = position
        self.monthlyIncome = monthlyIncome
        self.size = size
    }
}

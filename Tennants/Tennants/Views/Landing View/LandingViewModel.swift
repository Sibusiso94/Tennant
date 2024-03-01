import Foundation
import SwiftUI
import RealmSwift

enum Field: Int, Hashable {
    case name
    case address
}

enum TennantField: Int, Hashable {
    case name
    case address
    case buildingNumber
    case flatNumber
    case tennantID
    case company
    case position
    case monthlyIncome
}

enum ErrorMessage: String, Hashable {
    case numberOfUnitsError = "The number of flats occupied cannot exceed the number of units."
    case tenantIDError = "Invalid ID number"
}

class LandingViewModel: ObservableObject {
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var tennants: [Tennant] = []
    @Published var viewTitle: String = ""
    @Published var buttonTitle: String = ""
    @Published var toastMessage: String = ""
    @Published var numberOfUnitsOccupiedIsHigherThanUnits: Bool = false

    let realmRepository: RealmRepository
    var newProperty: Property = Property()
    var newPropertyFlats: [Flat] = []
    var newTennant: Tennant = Tennant()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
    }
    
    func setUpView(isAProperty: Bool) {
        if isAProperty {
            viewTitle = "Add a Property"
//            buttonTitle = 
        }
    }
    
    func addData() {
        if newData.isAProperty {
            addNewProperty()
        } else {
            addNewTennant()
        }
    }
    
    func clearData() {
        newData = NewDataModel()
    }
    
    private func addNewProperty() {
        let buildingID = UUID().uuidString
        let newPropoerty = Property(buildingID: buildingID,
                                    buildingName: newData.name,
                                    buildingAddress: newData.address,
                                    numberOfUnits: newData.numberOfUnits,
                                    numberOfUnitsOccupied: newData.numberOfUnitsOccupied)
        newPropertyFlats = setUpFlatsForNewProperty(numberOfUnits: Int(newData.numberOfUnits) ?? 1, buildingID: buildingID)
        newPropoerty.flats.append(objectsIn: newPropertyFlats)
        
//        try! realmRepository.update(insertions: [newPropoerty])
        properties.append(newPropoerty)
        clearData()
    }
    
    private func addNewTennant() {
        let date = Date.now
        #warning("Make sure ID is 13 digits")
        let newTennant = Tennant(buildingNumber: newData.buildingNumber,
                                flatNumber: newData.flatNumber,
                                 tennantID: newData.tennantID,
                                name: newData.name,
                                surname: newData.surname,
                                company: newData.company,
                                position: newData.position,
                                monthlyIncome: Int(newData.monthlyIncome) ?? 0,
                                balance: 0.0,
                                amountDue: 0.0,
                                startDate: getCurrentDate(date: date),
                                endDate: getEndDate(date: date),
                                fullPayments: 0)
        
//        try! realmRepository.update(insertions: [newTennant])
        tennants.append(newTennant)
        clearData()
    }
    
    func addNewTenantsToPropertyUnits() {
        newPropertyFlats
        tennants
    }
    
    private func setUpFlatsForNewProperty(numberOfUnits: Int, buildingID: String) -> [Flat] {
        var flats: [Flat] = []
        for unit in 0..<numberOfUnits {
            flats.append(Flat(flatNumber: unit, buildingID: buildingID))
        }
        
        return flats
    }
    
    private func getCurrentDate(date: Date) -> String {
        return date.getDateAsString()
    }
    
    private func getEndDate(date: Date) -> String {
        let dateInOneYear = Calendar.current.date(byAdding: .year, value: 1, to: date)
        return dateInOneYear?.getDateAsString() ?? date.getDateAsString()
    }
}

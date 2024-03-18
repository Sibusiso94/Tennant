import Foundation
import SwiftUI
import RealmSwift

enum Field: Int, Hashable {
    case name
    case address
}

enum ErrorMessage: String, Hashable {
    case numberOfUnitsError = "The number of units occupied cannot exceed the number of units."
    case tenantIDError = "Invalid ID number"
}

class LandingViewModel: ObservableObject {
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var tennants: [Tennant] = []
    @Published var selectedUnit: String = ""
    @Published var viewTitle: String = ""
    @Published var buttonTitle: String = ""
    @Published var toastMessage: String = ""
    @Published var numberOfUnitsOccupiedIsHigherThanUnits: Bool = false
    @Published var propertyType: PropertyOptions = .multipleUnits

    let realmRepository: RealmRepository
    @Published var newProperty: Property = Property()
    @Published var newPropertyUnits: [SingleUnit] = []
    @Published var newTennant: Tennant = Tennant()
    @Published var availableUnits: [MenuItemModel] = []
    @Published var isCompleteAddingUnits: Bool = false
    @Published var shouldShowAddUnits: Bool = false
    
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
//            addNewTenantsToPropertyUnits()
        }
    }
    
    func clearData() {
        newData = NewDataModel()
    }
    
    private func addNewProperty() {
        let buildingID = UUID().uuidString
        newProperty = Property(buildingID: buildingID,
                                    buildingName: newData.name,
                                    buildingAddress: newData.address,
                                    numberOfUnits: newData.numberOfUnits,
                                    numberOfUnitsOccupied: newData.numberOfUnitsOccupied)
        setUpUnitsForNewProperty(numberOfUnits: Int(newData.numberOfUnits) ?? 1, buildingID: buildingID) { isComplete in
            //        newProperty.units.append(objectsIn: newPropertyUnits)
            self.newProperty.units.append(objectsIn: [""])
            
            //        try! realmRepository.update(insertions: [newPropoerty])
            self.properties.append(self.newProperty)
            self.clearData()
            self.shouldShowAddUnits = true
        }
    }
    
    private func addNewTennant() {
        let date = Date.now
#warning("Make sure ID is 13 digits outide of view")
        newTennant = Tennant(buildingID: newData.buildingNumber,
                             unitID: newData.unitID,
                             tennantID: newData.tennantID,
                             name: newData.name,
                             surname: newData.surname,
                             currentAddress: newData.address,
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
    
//    func addNewTenantsToPropertyUnits() {
//        guard let index = newProperty.flats.firstIndex(where: { flat in
//            flat.id == newTennant.flatID
//        }) else { return }
//        
//        newProperty.flats[index].tennantID = newTennant.tennantID
//        print(newProperty)
//    }
    
//    func setUpFlatModel() {
//        availableUnits = newPropertyFlats.map { flat in
//            flat.id
//        }
//    }
    
    private func setUpUnitsForNewProperty(numberOfUnits: Int,
                                          buildingID: String,
                                          completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        var units: [SingleUnit] = []
        
        group.enter()
        for unit in 0..<numberOfUnits {
            units.append(SingleUnit(unitNumber: unit, buildingID: buildingID, numberOfBedrooms: 1, numberOfBathrooms: 1, isAvailable: false))
        }
        group.leave()
        
        group.notify(queue: .main) {
            self.newPropertyUnits = units.reversed()
            completion(true)
        }
    }
    
    private func getCurrentDate(date: Date) -> String {
        return date.getDateAsString()
    }
    
    private func getEndDate(date: Date) -> String {
        let dateInOneYear = Calendar.current.date(byAdding: .year, value: 1, to: date)
        return dateInOneYear?.getDateAsString() ?? date.getDateAsString()
    }
}

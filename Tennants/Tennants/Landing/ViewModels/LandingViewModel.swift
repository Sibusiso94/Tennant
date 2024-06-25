import Foundation
import SwiftUI
import SwiftData

enum Field: Int, Hashable {
    case name
    case address
}

enum PropertyOptions {
    case multipleUnits
    case singleUnit
}

enum ErrorMessage: String, Hashable {
    case numberOfUnitsError = "The number of units occupied cannot exceed the number of units."
    case tenantIDError = "Invalid ID number"
}

protocol NewPropertyManager {
    var newData: NewDataModel { get set }
    func createProperty()
    func generatePropertyUnits(buildingID: String, numberOfUnits: Int, completion: @escaping ([SingleUnit]) -> Void)
    func generatePropertyUnitsIDs(with units: [SingleUnit], completion: @escaping ([String]) -> Void)
}

class LandingViewModel: ObservableObject, NewPropertyManager {
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
//    @Query var properties: [Property] = []
    @Published var tenants: [Tennant] = []
    @Published var selectedUnit: String = ""
//    @Published var viewTitle: String = ""
//    @Published var buttonTitle: String = ""
//    @Published var toastMessage: String = ""
//    @Published var numberOfUnitsOccupiedIsHigherThanUnits: Bool = false
    @Published var propertyType: PropertyOptions = .multipleUnits
//
//    let realmRepository: RealmRepository
//    @Published var newProperty: Property = Property()
//    var newPropertyUnits: [SingleUnit] = []
//    @Published var newTennant: Tennant = Tennant()
//    @Published var availableUnits: [MenuItemModel] = []
//    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func createProperty() {
        let dispatchGroup = DispatchGroup()
        var newProperty = Property(buildingName: newData.name,
                                   buildingAddress: newData.address,
                                        numberOfUnits: newData.numberOfUnits,
                                        units: [])
        var units: [SingleUnit] = []
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        generatePropertyUnits(buildingID: newProperty.buildingID, numberOfUnits: numberOfUnits) { allUnits in
            units = allUnits
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        generatePropertyUnitsIDs(with: units) { ids in
            newProperty.units = ids
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.properties.append(newProperty)
            #warning("Create units in db")
        }
    }
    
    func generatePropertyUnitsIDs(with units: [SingleUnit], completion: @escaping ([String]) -> Void) {
        var unitIDs = units.map({$0.id})
        completion(unitIDs)
    }
    
    func generatePropertyUnits(buildingID: String,
                               numberOfUnits: Int,
                               completion: @escaping ([SingleUnit]) -> Void) {
        var newUnits: [SingleUnit] = []
        
        for unit in 1..<numberOfUnits {
            newUnits.append(SingleUnit(unitNumber: unit,
                                      buildingID: buildingID))
        }
        
        completion(newUnits)
    }
//
//    init(realmRepository: RealmRepository = RealmRepository()) {
//        self.realmRepository = realmRepository
//    }
}

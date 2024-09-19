import Foundation
import SwiftUI

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
    var dataProvider: PropertiesDataProvider { get }
    var unitManager: UnitManager { get }
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void)
}

class PropertiesManager: NewPropertyManager {
    let repository: RealmRepository
    let dataProvider: PropertiesDataProvider
    let unitManager: UnitManager
    let tenantManager: TenantManager
    
    var newProperty = Property()
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = PropertiesDataProvider(repository: repository)
        self.unitManager = UnitManager(repository: repository)
        self.tenantManager = TenantManager(repository: repository)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchProperties() -> [Property] {
        return dataProvider.fetchData()
    }
    
    func fetchPropertyUnits(_ selectedPropertyID: String) -> [SingleUnit] {
        return unitManager.fetchUnits(selectedPropertyID)
    }
    
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        newProperty = Property()
        newProperty = Property(buildingName: newData.name,
                                   buildingAddress: newData.address,
                                        numberOfUnits: newData.numberOfUnits)
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        unitManager.generatePropertyUnits(propertyId: newProperty.buildingID, numberOfUnits: numberOfUnits) { unitIds in
            self.newProperty.unitIDs.append(objectsIn: unitIds)  
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(self.newProperty)
            completion(true)
        }
    }
    
    func updateProperty(_ property: Property, completion: @escaping () -> Void) {
        dataProvider.update(property)
        completion()
    }
    
    func deleteProperty(_ property: Property) {
        dataProvider.delete(property)
    }
    
//    func addTenant(_ tenant: Tennant, to property: Property) {
//        property.
//    }
}

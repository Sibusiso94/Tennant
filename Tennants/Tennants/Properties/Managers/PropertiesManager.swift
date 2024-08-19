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
    var dataProvider: PropertiesDataProvider { get }
    var unitManager: UnitManager { get }
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void)
}

class PropertiesManager: NewPropertyManager {
    let modelContext: ModelContext
    let dataProvider: PropertiesDataProvider
    let unitManager: UnitManager
    var newProperty = Property()
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = PropertiesDataProvider(modelContext: modelContext)
        self.unitManager = UnitManager(modelContext: modelContext)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchProperties() -> [Property] {
        return dataProvider.fetchData()
    }
    
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        newProperty = Property()
        newProperty = Property(buildingName: newData.name,
                                   buildingAddress: newData.address,
                                        numberOfUnits: newData.numberOfUnits)
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        unitManager.generatePropertyUnits(property: newProperty, numberOfUnits: numberOfUnits) { allUnits in
            self.newProperty.units = allUnits
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(self.newProperty)
            completion(true)
        }
    }
    
    func updateProperty(_ property: Property) {
        let updatedProperty = Property()
        updatedProperty.buildingName = property.buildingName
        dataProvider.update(updatedProperty)
    }
    
    func deleteProperty(_ property: Property) {
        dataProvider.delete(property)
    }
}

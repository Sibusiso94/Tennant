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
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void)
    func generatePropertyUnits(property: Property, numberOfUnits: Int, completion: @escaping ([SingleUnit]) -> Void)
}

class PropertiesManager: NewPropertyManager {
    let modelContext: ModelContext
    let dataProvider: PropertiesDataProvider
    let unitDataProvider: UnitsDataProvider
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = PropertiesDataProvider(modelContext: modelContext)
        self.unitDataProvider = UnitsDataProvider(modelContext: modelContext)
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
        let newProperty = Property(buildingName: newData.name,
                                   buildingAddress: newData.address,
                                        numberOfUnits: newData.numberOfUnits)
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        generatePropertyUnits(property: newProperty, numberOfUnits: numberOfUnits) { allUnits in
            self.unitDataProvider.createMultiple(allUnits)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        newProperty.units = self.unitDataProvider.fetchData()
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(newProperty)
            completion(true)
        }
    }
    
    func generatePropertyUnits(property: Property,
                               numberOfUnits: Int,
                               completion: @escaping ([SingleUnit]) -> Void) {
        var newUnits: [SingleUnit] = []
        
        for unit in 1..<numberOfUnits {
            let newUnit = SingleUnit(unitNumber: unit,
                                     property: property)
            self.unitDataProvider.create(newUnit)
            newUnits.append(newUnit)
        }
        
        completion(newUnits)
    }
    
    func deleteProperties(property: Property) {
        dataProvider.delete(property)
    }
}

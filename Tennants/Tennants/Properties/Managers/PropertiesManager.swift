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
    func generatePropertyUnits(buildingID: String, numberOfUnits: Int, completion: @escaping ([SingleUnit]) -> Void)
    func generatePropertyUnitsIDs(with units: [SingleUnit], completion: @escaping ([String]) -> Void)
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
                                        numberOfUnits: newData.numberOfUnits,
                                        units: [])
        var units: [SingleUnit] = []
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        generatePropertyUnits(buildingID: newProperty.buildingID, numberOfUnits: numberOfUnits) { allUnits in
            units = allUnits
            self.unitDataProvider.createMultiple(allUnits)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        generatePropertyUnitsIDs(with: units) { ids in
            newProperty.units = ids
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(newProperty)
            completion(true)
        }
    }
    
    func generatePropertyUnits(buildingID: String,
                               numberOfUnits: Int,
                               completion: @escaping ([SingleUnit]) -> Void) {
        var newUnits: [SingleUnit] = []
        
        for unit in 1..<numberOfUnits {
            let newUnit = SingleUnit(unitNumber: unit,
                                     buildingID: buildingID)
            self.unitDataProvider.create(newUnit)
            newUnits.append(newUnit)
        }
        
        completion(newUnits)
    }
    
    func generatePropertyUnitsIDs(with units: [SingleUnit], completion: @escaping ([String]) -> Void) {
        let unitIDs = units.map({$0.id})
        completion(unitIDs)
    }
}

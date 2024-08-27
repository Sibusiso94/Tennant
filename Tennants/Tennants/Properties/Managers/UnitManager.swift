import Foundation
import SwiftData

class UnitManager {
    let modelContext: ModelContext
    let unitDataProvider: UnitsDataProvider
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.unitDataProvider = UnitsDataProvider(modelContext: modelContext)
    }
    
    func fetchUnitBy(_ property: Property) -> [SingleUnit] {
        let data = unitDataProvider.fetchData()
        let filteredData = data.filter { $0.property == property }
        return filteredData
    }
    
    func generatePropertyUnits(property: Property,
                               numberOfUnits: Int,
                               completion: @escaping ([SingleUnit]) -> Void) {
        var newUnits: [SingleUnit] = []
        
        for unit in 1..<numberOfUnits + 1 {
            let newUnit = SingleUnit(unitNumber: unit,
                                     property: property)
            newUnits.append(newUnit)
        }
        
        completion(newUnits)
    }
    
    func updateUnit() {
        
    }
}

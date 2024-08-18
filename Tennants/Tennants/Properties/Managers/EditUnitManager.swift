import Foundation
import SwiftData

class UnitManager {
    let modelContext: ModelContext
    let unitDataProvider: UnitsDataProvider
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.unitDataProvider = UnitsDataProvider(modelContext: modelContext)
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
}

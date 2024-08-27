import Foundation
import SwiftData

class TenantManager {
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addTenant(_ tenant: Tennant, selectedUnitID: String, property: inout Property, completion: @escaping () -> Void) {
        for (index, unit) in property.units.enumerated() {
            if unit.id == selectedUnitID {
                property.units[index].tenant = tenant
                completion()
            }
        }
//        return property
    }
}

import Foundation

class TenantManager {
    init() { }
    
    func addTenant(tenantID: String,
                   unitID: String,
                   property: inout Property,
                   completion: @escaping () -> Void) {
        for (index, id) in property.unitIDs.enumerated() {
            if unitID == id {
                property.unitIDs[index] = tenantID
                completion()
            }
        }
    }
}

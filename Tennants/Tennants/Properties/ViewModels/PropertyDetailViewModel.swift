import Foundation

class PropertyDetailViewModel: ObservableObject {
    @Published var selectedTenant = UnitCardModel()
    @Published var unit = SingleUnit()

    let unitManager: UnitManager
    let tenantManager: TenantManager

    init(unitManager: UnitManager, tenantManager: TenantManager) {
        self.unitManager = unitManager
        self.tenantManager = tenantManager
    }

    func fetchUnit(_ unitId: String) {
        if let selectedUnit = unitManager.fetchUnitsBy(unitId: unitId) {
            unit = selectedUnit
        }
    }

    @MainActor
    func addTenant(_ tenant: Tennant, propertyID: String, unitId: String) {
        tenantManager.addTenant(propertyID: propertyID,
                                unitID: unitId,
                                tenant: tenant) { tenantId in
            self.unitManager.dataProvider.update(id: unitId, tenantId: tenantId)
//            tenant.reference
        }
    }

    @MainActor
    func updateUnit(id: String,
                    tenantId: String? = nil,
                    beds: Int? = nil,
                    baths: Int? = nil,
                    size: Int? = nil) {
        unitManager.updateUnits(id: id,
                                tenantId: tenantId,
                                beds: beds,
                                baths: baths,
                                size: size)
    }

    func safeStringToInt(_ string: String) -> Int {
        if let newInt = Int(string) {
            return newInt
        }
        
        return 0
    }
    
//    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
//        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
//        return sortedUnits
//    }
}

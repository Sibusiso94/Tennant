import Foundation

class PropertyDetailViewModel: ObservableObject {
    @Published var selectedTenant = UnitCardModel()
    @Published var unit = SingleUnit()


    let unitManager: UnitManager

    init(unitManager: UnitManager) {
        self.unitManager = unitManager
    }

    func fetchUnit(_ unitId: String) {
        if let selectedUnit = unitManager.fetchUnitsBy(unitId: unitId) {
            unit = selectedUnit
        }
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

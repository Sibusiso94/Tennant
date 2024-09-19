import Foundation

class UnitManager {
    let repository: RealmRepository
    let dataProvider: UnitsDataProvider
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = UnitsDataProvider(repository: repository)
    }
    
    func fetchUnits(_ propertyId: String) -> [SingleUnit] {
        let data = dataProvider.fetchData()
        let filteredData = data.filter { $0.propertyId == propertyId }
        let orderedUnits = filteredData.sorted(by: { $0.unitNumber < $1.unitNumber })
        return orderedUnits
    }
    
    func generatePropertyUnits(propertyId: String,
                               numberOfUnits: Int,
                               completion: @escaping ([String]) -> Void) {
        var newUnits: [SingleUnit] = []
        
        for unit in 1..<numberOfUnits + 1 {
            let newUnit = SingleUnit(unitNumber: unit,
                                     propertyId: propertyId)
            newUnits.append(newUnit)
        }
        
        dataProvider.createMultiple(newUnits)
        let unitIds = getUnitIds(with: newUnits)
        completion(unitIds)
    }
    
    func getUnitIds(with units: [SingleUnit]) -> [String] {
        var ids: [String] = []
        for unit in units {
            ids.append(unit.id)
        }
        
        return ids
    }
}

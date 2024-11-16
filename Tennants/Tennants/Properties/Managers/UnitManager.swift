import Foundation

class UnitManager {
    let repository: RealmRepository
    let dataProvider: UnitsDataProvider
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = UnitsDataProvider(repository: repository)
    }
    
    func fetchUnitsBy(propertyId: String) -> [SingleUnit] {
        let data = dataProvider.fetchData()
        let filteredData = data.filter { $0.propertyId == propertyId }
        let orderedUnits = filteredData.sorted(by: { $0.unitNumber < $1.unitNumber })
        return orderedUnits
    }

    func fetchUnitsBy(unitId: String) -> SingleUnit? {
        let data = dataProvider.fetchData()
        if let filteredData = data.first(where: { $0.id == unitId } ) {
            return filteredData
        }
        return nil
    }

    func generatePropertyUnits(propertyId: String,
                               numberOfUnits: Int,
                               numberOfBeds: Int? = nil,
                               numberOfBaths: Int? = nil,
                               size: Int? = nil,
                               completion: @escaping ([String]) -> Void) {
        var newUnits: [SingleUnit] = []

        if let numberOfBeds, let numberOfBaths, let size {
            let newUnit = SingleUnit(unitNumber: 1,
                                     propertyId: propertyId,
                                     numberOfBedrooms: numberOfBeds,
                                     numberOfBathrooms: numberOfBaths,
                                     size: size)

            dataProvider.create(newUnit)
            completion([newUnit.id])
        } else {
            for unit in 1..<numberOfUnits + 1 {
                let newUnit = SingleUnit(unitNumber: unit,
                                         propertyId: propertyId)
                newUnits.append(newUnit)
            }

            dataProvider.createMultiple(newUnits)
            let unitIds = getUnitIds(with: newUnits)
            completion(unitIds)
        }
    }
    
    func getUnitIds(with units: [SingleUnit]) -> [String] {
        var ids: [String] = []
        for unit in units {
            ids.append(unit.id)
        }
        
        return ids
    }

    func updateUnits(id: String,
                     tenantId: String? = nil,
                     beds: Int? = nil,
                     baths: Int? = nil,
                     size: Int? = nil) {
        dataProvider.update(id: id,
                            tenantId: tenantId,
                            numberOfBedrooms: beds,
                            numberOfBathrooms: baths,
                            size: size)
    }

    func deleteUnits(with propertyId: String, completion: ([String]) -> Void) {
        let data = dataProvider.fetchData()
        var unitIds = [String]()
        for unit in data {
            if unit.propertyId == propertyId {
                unitIds.append(unit.id)
                dataProvider.delete(unit.id)
            }
        }
        
        completion(unitIds)
    }
}

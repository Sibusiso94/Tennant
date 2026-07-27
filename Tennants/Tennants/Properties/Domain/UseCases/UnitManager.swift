import Foundation

class UnitManager: UnitMangerProtocol {
    let repository: DataSource

    init(repository: DataSource) {
        self.repository = repository
    }
    
    func fetchUnitsBy(propertyId: String) -> [SingleUnit] {
        let data = repository.readAll(SingleUnit.self)
        let filteredData = data.filter { $0.propertyId == propertyId }
        let orderedUnits = filteredData.sorted(by: { $0.unitNumber < $1.unitNumber })
        return orderedUnits
    }

    func fetchUnitBy(unitId: String) -> SingleUnit? {
        let data = repository.readAll(SingleUnit.self)
        if let filteredData = data.first(where: { $0.id == unitId } ) {
            return filteredData
        }
        return nil
    }

    func addPropertyUnit(unit: SingleUnit) async throws -> String {
        try repository.create(unit)
        return unit.id
    }

    func getUnitIds(with units: [SingleUnit]) -> [String] {
        var ids: [String] = []
        for unit in units {
            ids.append(unit.id)
        }
        
        return ids
    }

    func updateUnit(
        unitId: String,
        tenantId: String
    ) {
        update(
            id: unitId,
            tenantId: tenantId
        )
    }

    func deleteUnits(with propertyId: String) async throws {
        let data = repository.readAll(SingleUnit.self)
        var unitIds = [String]()
        for unit in data {
            if unit.propertyId == propertyId {
                unitIds.append(unit.id)
                try repository.delete(unit.id, ofType: SingleUnit.self)
            }
        }
    }

    private func update(
        id: String,
        tenantId: String? = nil
    ) {
        guard let unitToUpdate = repository.readAll(SingleUnit.self).first(where: { $0.id == id }) else {
            print("Unit not found")
            return
        }

        if let tenantId {
            unitToUpdate.tenantID = tenantId
            unitToUpdate.isOccupied = true
        } else {
            unitToUpdate.isOccupied = false
        }

        do {
            try repository.update(unitToUpdate)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

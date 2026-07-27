protocol UnitMangerProtocol {
    func addPropertyUnit(unit: SingleUnit) async throws -> String
    func fetchUnitBy(unitId: String) -> SingleUnit?
    func fetchUnitsBy(propertyId: String) -> [SingleUnit]
    func updateUnit(unitId: String, tenantId: String)
    func deleteUnits(with propertyId: String) async throws
}

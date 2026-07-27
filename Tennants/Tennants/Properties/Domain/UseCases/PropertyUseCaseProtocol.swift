protocol PropertyUseCaseProtocol {
    func fetchProperties() -> [Property]
    func fetchPropertyUnits(_ selectedPropertyID: String) -> [SingleUnit]
    func createProperty(newData: NewDataModel, propertyType: PropertyOptions) async throws
    func deleteProperty(_ propertyId: String) async throws
    func getTenantCardData(units: [SingleUnit]) -> [UnitCardModel]
}

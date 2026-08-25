import Foundation

class TenantManager: TenantManagerProtocol, TenantProprtyDetailsProtocol {
    let repository: DataSource

    init(repository: DataSource) {
        self.repository = repository
    }

    func fetchTenants() -> [Tennant] {
        repository.readAll(Tennant.self)
    }
    
    func fetchTenantBy(_ id: String) -> Tennant? {
        let tenants = repository.readAll(Tennant.self)
        return tenants.first(where: { $0.id == id })
    }

    func fetchTenantBy(property: String, and unit: String) -> Tennant? {
        let tenants = repository.readAll(Tennant.self)
        return tenants.first(where: { $0.propertyID == property && $0.unitID == unit} )
    }

    func getPropertyName(propertyId: String) -> String {
        let properties = repository.readAll(Property.self)
        guard let selectedProperty = properties.first(where: { $0.buildingID == propertyId } ) else { return "" }
        return selectedProperty.buildingName
    }

    func getUnitName(tenantId: String) -> String {
        let units = repository.readAll(SingleUnit.self)
        guard let selectedUnit = units.first(where: { $0.tenantID == tenantId }) else { return "" }
        return String(selectedUnit.unitNumber)
    }

    func addTenant(propertyID: String,
                   unitID: String,
                   tenant: Tennant) async throws {
        let newTenantId = UUID().uuidString
        let newTenant = Tennant(id: newTenantId,
                                propertyID: propertyID,
                                unitID: unitID,
                                tennantID: tenant.tennantID,
                                name: tenant.name,
                                surname: tenant.surname,
                                reference: tenant.reference,
                                currentAddress: tenant.currentAddress,
                                company: tenant.company,
                                position: tenant.position,
                                monthlyIncome: tenant.monthlyIncome,
                                balance: tenant.balance,
                                amountDue: tenant.amountDue,
                                startDate: tenant.startDate,
                                endDate: tenant.endDate)
        
        try repository.create(newTenant)
    }
    
    func deleteTenants(from tenantId: String) async throws {
        try repository.delete(tenantId, ofType: Tennant.self)
    }

    func deleteTenants(with propertyId: String) async throws {
        try repository.delete(propertyId, ofType: Tennant.self)
    }
}

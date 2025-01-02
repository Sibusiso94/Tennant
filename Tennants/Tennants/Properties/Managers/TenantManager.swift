import Foundation

class TenantManager {
    let repository: RealmRepository
    let dataProvider: TenantDataProvider    
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = TenantDataProvider(repository: repository)
    }

    func fetchAll() -> [Tennant] {
        dataProvider.fetchData()
    }

    func fetchTenant(from unitID: String) -> Tennant? {
        let tenants = dataProvider.fetchData()
        let unitTenants = tenants.first(where: { $0.unitID == unitID } )
        return unitTenants
    }
    
    func fetchTenantBy(_ id: String) -> Tennant? {
        return dataProvider.fetchData(by: id)
    }
    
    func addTenant(propertyID: String,
                   unitID: String,
                   tenant: Tennant,
                   completion: @escaping (String) -> Void) {
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
        
        dataProvider.create(newTenant)
        completion(newTenantId)
    }
    
    func deleteTenants(from unitIds: [String]) {
        let data = dataProvider.fetchData()
        let tenantsToDelete = data.filter { unitIds.contains($0.unitID) }
        
        for tenant in tenantsToDelete {
            dataProvider.delete(tenant.id)
        }
    }
}

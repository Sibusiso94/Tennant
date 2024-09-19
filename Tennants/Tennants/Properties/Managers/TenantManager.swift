import Foundation

class TenantManager {
    let repository: RealmRepository
    let dataProvider: TenantDataProvider    
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = TenantDataProvider(repository: repository)
    }
    
    func fetchTenant(from unitID: String) -> Tennant? {
        let tenants = dataProvider.fetchData()
        let unitTenants = tenants.first(where: { $0.unitID == unitID } )
        return unitTenants
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
}

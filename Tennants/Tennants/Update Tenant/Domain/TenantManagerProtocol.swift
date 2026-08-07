protocol TenantManagerProtocol {
    func fetchTenants() -> [Tennant]
    func fetchTenantBy(_ id: String) -> Tennant?
    func fetchTenantBy(property: String, and unit: String) -> Tennant?
    func addTenant(propertyID: String,
                   unitID: String,
                   tenant: Tennant) async throws
    func deleteTenants(from tenantId: String) async throws
    func deleteTenants(with propertyId: String) async throws
}

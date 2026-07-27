protocol ReferencesManagable {
    func uploadReference(unitId: String, tenantId: String, reference: String) async throws
}

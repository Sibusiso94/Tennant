import Foundation

@Observable
class PropertyDetailViewModel {

    // MARK: Dependencies
    private let referenceManager: ReferencesManagable
    private let unitManager: UnitMangerProtocol
    private let tenantManager: TenantManagerProtocol

    // MARK: Variables
    var selectedTenant = UnitCardModel()
    var unit: SingleUnit?
    var shouldShowError = false
    var errorMessage: String?

    init(
        referenceManager: ReferencesManagable,
        unitManager: UnitMangerProtocol,
        tenantManager: TenantManagerProtocol
    ) {
        self.referenceManager = referenceManager
        self.unitManager = unitManager
        self.tenantManager = tenantManager
    }

    convenience init() {
        let referenceManager = DIContainer.shared.resolve(ReferencesManagable.self)
        let unitManager = DIContainer.shared.resolve(UnitMangerProtocol.self)
        let tenantManager = DIContainer.shared.resolve(TenantManagerProtocol.self)

        self.init(
            referenceManager: referenceManager,
            unitManager: unitManager,
            tenantManager: tenantManager
        )
    }

    func fetchUnit(_ unitId: String) {
        if let selectedUnit = unitManager.fetchUnitBy(unitId: unitId) {
            unit = selectedUnit
        }
    }

    @MainActor
    func addTenant(
        _ tenant: Tennant,
        propertyID: String,
        unitId: String
    ) {
        Task {
            do {
                try await tenantManager.addTenant(propertyID: propertyID,
                                        unitID: unitId,
                                        tenant: tenant)
                unitManager.updateUnit(unitId: unitId, tenantId: tenant.tennantID)
                uploadReferences(
                    unitId: unitId,
                    tenantId: tenant.tennantID,
                    reference: tenant.reference
                )
            } catch {
                errorMessage = "Could not add tenant. Please try again."
                shouldShowError = true
            }
        }
    }

    func uploadReferences(
        unitId: String,
        tenantId: String,
        reference: String
    ) {
        Task {
            do {
                try await referenceManager.uploadReference(
                    unitId: unitId,
                    tenantId: tenantId,
                    reference: reference
                )
            } catch {
                shouldShowError = true
            }
        }
    }

    @MainActor
    func updateUnit(unitId: String,
                    tenantId: String) {
        unitManager.updateUnit(unitId: unitId, tenantId: tenantId)
    }

    private func safeStringToInt(_ string: String) -> Int {
        if let newInt = Int(string) {
            return newInt
        }
        
        return 0
    }
    
//    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
//        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
//        return sortedUnits
//    }
}

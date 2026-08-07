import Foundation

@Observable
class PropertyDetailViewModel {

    // MARK: Dependencies
    private let referenceManager: ReferencesManagable
    private let unitManager: UnitMangerProtocol
    private let tenantManager: TenantManagerProtocol

    // MARK: Variables
    var tenant: Tennant?
    var selectedTenant = UnitCardModel()
    var unit: SingleUnit?

    var hasTenant: Bool = false
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

    private func fetchTenant(
        propertyId: String,
        unitId: String,
        unitNumber: String
    ) {
        if let tenantData = tenantManager.fetchTenantBy(property: propertyId, and: unitId) {
            tenant = tenantData
            selectedTenant = UnitCardModel(
                unitId: unitId,
                unitNumber: unitNumber,
                name: tenantData.name,
                surname: tenantData.surname,
                balance: String(tenantData.balance),
                amount: String(tenantData.amountDue),
                isOccupied: true
            )
            hasTenant = true
        } else {
            hasTenant = false
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

    @MainActor
    func updateUnit(unitId: String,
                    tenantId: String) {

        unitManager.updateUnit(unitId: unitId, tenantId: tenantId)
    }



    func setUpSingleUnit(propertyId: String, unitId: String) {
        fetchUnit(unitId)
        fetchTenant(
            propertyId: propertyId,
            unitId: unitId,
            unitNumber: String(unit?.unitNumber ?? 0)
        )
    }

    private func safeStringToInt(_ string: String) -> Int {
        if let newInt = Int(string) {
            return newInt
        }
        
        return 0
    }

    private func uploadReferences(
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

//    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
//        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
//        return sortedUnits
//    }
}

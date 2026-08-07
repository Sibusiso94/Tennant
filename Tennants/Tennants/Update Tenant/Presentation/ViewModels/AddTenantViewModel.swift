import Foundation

@Observable
class AddTenantViewModel {
    private let manager: TenantManagerProtocol

    var tenant = Tennant()
    var showErrorMessage: Bool = false
    var showAlert: Bool = false
    var startDate = Date.now
    var endDate = Date.now

    init(manager: TenantManagerProtocol) {
        self.manager = manager
    }

    convenience init() {
        let manager = DIContainer.shared.resolve(TenantManagerProtocol.self)

        self.init(manager: manager)
    }

    func addTenant(
        propertyID: String,
        unitID: String
    ) {
        Task {
            do {
                try await manager.addTenant(propertyID: propertyID, unitID: unitID, tenant: tenant)
                showAlert = true
            } catch {
                showErrorMessage = true
                print("error")
            }
        }
    }

    func dateOneYearFromNow() {
        var components = DateComponents()
        components.year = 1
        endDate = Calendar.current.date(byAdding: components, to: Date.now) ?? Date.now
    }

    func checkIDNumber(text: String) -> Bool {
        if text.count == 13 {
            return true
        } else {
            return false
        }
    }
}

import Foundation
import SwiftUI

@Observable
class PropertiesViewModel {
    private let manager: PropertyUseCaseProtocol
    private let tenantManager: TenantManagerProtocol

    /// Navigation is delegated upward to the coordinator. `weak` avoids a retain
    /// cycle since the coordinator strongly owns this view model.
    @ObservationIgnored weak var coordinator: (any Coordinator<PropertiesRoute>)?

    var propertyType: PropertyOptions = .multipleUnits
    
    var newData: NewDataModel = NewDataModel()
    var properties: [Property] = []
    var selectedProperty = Property()

    var selectedTenant: Tennant?
    var selectedUnit: SingleUnit?
    var selectedUnitCard: UnitCardModel?
    var unitCardModel: [UnitCardModel] = []

    var unitImage: String?

    var uploadStatus: String = ""
    var showUploadStatus: Bool = false
    var showAlert: Bool = false
    
    init(
        manager: PropertyUseCaseProtocol,
        tenantManager: TenantManagerProtocol
    ) {
        self.manager = manager
        self.tenantManager = tenantManager
        self.refreshData()
    }

    convenience init() {
        let manager = DIContainer.shared.resolve(PropertyUseCaseProtocol.self)
        let tenantManager = DIContainer.shared.resolve(TenantManagerProtocol.self)

        self.init(manager: manager, tenantManager: tenantManager)
    }

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @MainActor
    func addProperty() {
        Task {
            do {
                try await manager.createProperty(newData: newData, propertyType: propertyType)
                self.showAlert = true
                self.setUpStatus(message: "Property saved successfully.")
                self.clearData()
            } catch {
                self.setUpStatus(message: "Something went wrong.")
                self.clearData()
            }
        }
    }

    func fetchProperties() -> [Property] {
        manager.fetchProperties()
    }

    func selectedProperty(_ property: Property) {
        selectedProperty = property
        let units = manager.fetchPropertyUnits(property.buildingID)
        unitCardModel = manager.getTenantCardData(units: units)
        navigate(to: .propertyDetail)
    }

    func showPropertyOptions() {
        navigate(to: .propertyOptions)
    }

    func managePropertyOptions(_ selectedOption: Int) {
        if selectedOption == 1 {
            propertyType = .singleUnit
        } else {
            propertyType = .multipleUnits
        }

        navigate(to: .addProperty)
    }

    func showAddTenant() {
        navigate(to: .addTenant)
    }

    func editUnit() {
        propertyType = .singleUnit
        navigate(to: .editUnit)
    }

    /// Called from the "Property successfully added" alert. Refreshes the grid
    /// and returns to the root of the flow so the new property is visible.
    func didConfirmPropertyAdded() {
        refreshData()
        navigate(to: .popToRoot)
    }

    /// Forwards a navigation intent to the coordinator. The view never talks to
    /// the coordinator directly — it only calls the intent methods above.
    private func navigate(to route: PropertiesRoute) {
        Task { [weak self] in
            try? await self?.coordinator?.route(to: route)
        }
    }
    
    private func setUpStatus(message: String) {
        uploadStatus = message
        showUploadStatus = true
    }
    
    private func clearData() {
        newData = NewDataModel()
    }
    
    func refreshData() {
        properties = manager.fetchProperties()
    }
    
    @MainActor
    func delete(_ propertyId: String) {
        Task {
            try await manager.deleteProperty(propertyId)
            properties.removeAll(where: { $0.buildingID == propertyId })
        }
    }
    
    func getTenant(with id: String)  -> Tennant? {
        tenantManager.fetchTenantBy(id)
    }

    func setUpCardDetail(with tenant: UnitCardModel) {
        selectedUnitCard = tenant
        unitImage = "room\(tenant.unitNumber)"
        if tenant.isOccupied {
            selectedTenant = getTenant(with: tenant.unitId)
            selectedUnit?.unitNumber = Int(tenant.unitNumber) ?? 0
        }

        navigate(to: .unitDetail)
    }
}

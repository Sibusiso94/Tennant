import Foundation
import SwiftUI

@Observable
class PropertiesViewModel {
    private let manager: PropertyUseCaseProtocol
    private let tenantManager: TenantManagerProtocol
    var propertyType: PropertyOptions = .multipleUnits
    
    var newData: NewDataModel = NewDataModel()
    var properties: [Property] = []
    var selectedProperty = Property()

    var selectedTenant: Tennant?
    var selectedUnit: SingleUnit?
    var unitCardModel: [UnitCardModel] = []

    var unitImage: String?
    var shouldShowAddProperty: Bool = false
    var shouldAddPropertyOptions: Bool = false
//    @Published var showTennantView: Bool = false
    
    var uploadStatus: String = ""
    var showUploadStatus: Bool = false
    var showPropertyDetailView: Bool = false

    var showUnitDetailView: Bool = false
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
        showPropertyDetailView = true
    }
    
    func managePropertyOptions(_ selectedOption: Int) {
        if selectedOption == 1 {
            propertyType = .singleUnit
        } else {
            propertyType = .multipleUnits
        }
        
        shouldShowAddProperty = true
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
        unitImage = "room\(tenant.unitNumber)"
        if tenant.isOccupied {
            selectedTenant = getTenant(with: tenant.unitId)
            selectedUnit?.unitNumber = Int(tenant.unitNumber) ?? 0
            showUnitDetailView.toggle()
        } else {
            showUnitDetailView.toggle()
        }
    }
}

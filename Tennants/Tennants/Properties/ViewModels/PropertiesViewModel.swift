import Foundation
import SwiftUI

class PropertiesViewModel: ObservableObject {
    let repository: RealmRepository
    let manager: PropertiesManager
    let tenantManager: TenantManager
    var propertyType: PropertyOptions = .multipleUnits
    
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var selectedProperty = Property()
    
    @Published var selectedTenant = Tennant()
    @Published var tenants: [Tennant] = []
    @Published var allUnits: [SingleUnit] = []
    @Published var selectedUnit = SingleUnit()
    
    @Published var shouldShowAddProperty: Bool = false
    @Published var shouldAddPropertyOptions: Bool = false
    @Published var showTennantView: Bool = false
    
    @Published var uploadStatus: String = ""
    @Published var showUploadStatus: Bool = false
    @Published var showPropertyDetailView: Bool = false
    
    @Published var showAlert: Bool = false
    
    init() {
        self.repository = RealmRepository()
        self.manager = PropertiesManager(repository: repository)
        self.tenantManager = TenantManager()
        self.refreshData()
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func addProperty() {
        selectedProperty = Property()
        manager.createProperty(newData: newData) { success in
            if success {
                self.showAlert = true
                self.setUpStatus(message: "Property saved successfully.")
                self.clearData()
            } else {
                self.setUpStatus(message: "Something went wrong.")
                self.clearData()
            }
        }
    }
    
    func selectedProperty(_ property: Property) {
        selectedProperty = property
        showPropertyDetailView = true
        allUnits = manager.fetchPropertyUnits(property.buildingID)
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
    
    func addTenant() {
        manager.updateProperty(selectedProperty) {
            self.refreshTenant()
        }
//        tenantManager.addTenant(selectedTenant, selectedUnitID: selectedUnit.id, property: &selectedProperty) {
//            self.manager.updateProperty(self.selectedProperty) {
//            }
//            self.manager.fetchProperties()
//        }
    }
    
    func refreshTenant() {
        selectedTenant.name = ""
        selectedTenant.currentAddress = ""
        selectedTenant.reference = ""
        selectedTenant.tennantID = ""
        selectedTenant.company = ""
        selectedTenant.position = ""
        selectedTenant.monthlyIncome = ""
    }
}

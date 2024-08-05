import Foundation
import SwiftUI
import SwiftData

class PropertiesViewModel: ObservableObject {
    let modelContext: ModelContext
    let manager: PropertiesManager
    var propertyType: PropertyOptions = .multipleUnits
    
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var selectedProperty = Property()
    @Published var tenants: [Tennant] = []
    
    @Published var shouldShowAddProperty: Bool = false
    @Published var shouldAddPropertyOptions: Bool = false
    @Published var showTennantView: Bool = false
    
    @Published var uploadStatus: String = ""
    @Published var showUploadStatus: Bool = false
    @Published var showPropertyDetailView: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.manager = PropertiesManager(modelContext: modelContext)
        self.properties = self.manager.fetchProperties()
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func addProperty() {
        manager.createProperty(newData: newData) { success in
            if success {
                self.properties = self.manager.fetchProperties()
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
}

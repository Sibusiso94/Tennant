import Foundation
import SwiftUI
import SwiftData

class PropertiesViewModel: ObservableObject {
    let modelContext: ModelContext
    let manager: PropertiesManager
    
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var tenants: [Tennant] = []
    
    @Published var selectedUnit: String = ""
    @Published var propertyType: PropertyOptions = .multipleUnits
    
    @Published var shouldShowAddProperty: Bool = false
    @Published var shouldAddPropertyOptions: Bool = false
    @Published var showTennantView: Bool = false
    
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
                print("===============")
                print("Saved successfully")
            }
        }
    }
}

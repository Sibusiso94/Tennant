import Foundation
import SwiftUI
import SwiftData

enum Field: Int, Hashable {
    case name
    case address
}

enum PropertyOptions {
    case multipleUnits
    case singleUnit
}

enum ErrorMessage: String, Hashable {
    case numberOfUnitsError = "The number of units occupied cannot exceed the number of units."
    case tenantIDError = "Invalid ID number"
}

protocol NewPropertyManager {
    var dataProvider: PropertiesDataProvider { get }
    var unitManager: UnitManager { get }
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void)
}

class PropertiesManager: NewPropertyManager {
    let modelContext: ModelContext
    let dataProvider: PropertiesDataProvider
    let unitManager: UnitManager
    var newProperty = Property()
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dataProvider = PropertiesDataProvider(modelContext: modelContext)
        self.unitManager = UnitManager(modelContext: modelContext)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchProperties() -> [Property] {
        return dataProvider.fetchData()
    }
    
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        newProperty = Property()
        newProperty = Property(buildingName: newData.name,
                                   buildingAddress: newData.address,
                                        numberOfUnits: newData.numberOfUnits)
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        unitManager.generatePropertyUnits(property: newProperty, numberOfUnits: numberOfUnits) { allUnits in
            self.newProperty.units = allUnits
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(self.newProperty)
            completion(true)
        }
    }
    
    func updateProperty(_ property: Property, completion: @escaping () -> Void) {
        let tempProperty = createTempProperty(with: property)
        dataProvider.delete(property)
        dataProvider.create(getUpdatedPropertyUsingTempProperty(tempProperty))
        completion()
    }
    
    private func getUpdatedPropertyUsingTempProperty(_ property: TempProperty) -> Property {
        let updatedProperty = Property(buildingID: property.buildingID,
                                      buildingName: property.buildingName,
                                      buildingAddress: property.buildingAddress,
                                      numberOfUnits: property.numberOfUnits)
        updatedProperty.units = getUpdatedUnitsUsingTempUnits(property.units, property: updatedProperty)
        return updatedProperty
    }
    
    private func createTempProperty(with property: Property) -> TempProperty {
        let tempProperty = TempProperty(buildingID: property.buildingID,
                                        buildingName: property.buildingName,
                                        buildingAddress: property.buildingAddress,
                                        numberOfUnits: property.numberOfUnits)
        tempProperty.units = craeteTempUnits(property.units, property: tempProperty)
        return tempProperty
    }
    
    private func craeteTempUnits(_ units: [SingleUnit], property: TempProperty) -> [TempSingleUnit] {
        var updatedUnit: [TempSingleUnit] = []
        for unit in units {
            updatedUnit.append(TempSingleUnit(id: unit.id,
                                              unitNumber: unit.unitNumber,
                                              property: property,
                                              tenant: createTempTenant(tenant: unit.tenant),
                                              numberOfBedrooms: unit.numberOfBedrooms,
                                              numberOfBathrooms: unit.numberOfBathrooms,
                                              isOccupied: unit.isOccupied))
        }
        
        return updatedUnit
    }
    
    func createTempTenant(tenant: Tennant) -> TempTennant {
        var updatedTenant = TempTennant()
        updatedTenant.id = tenant.id
        updatedTenant.buildingNumber = tenant.buildingNumber
        updatedTenant.unitID = tenant.unitID
        updatedTenant.tennantID = tenant.tennantID
        updatedTenant.name = tenant.name
        updatedTenant.surname = tenant.surname
        updatedTenant.reference = tenant.reference
        updatedTenant.currentAddress = tenant.currentAddress
        updatedTenant.company = tenant.company
        updatedTenant.position = tenant.position
        updatedTenant.monthlyIncome = tenant.monthlyIncome
        updatedTenant.balance = tenant.balance
        updatedTenant.amountDue = tenant.amountDue
        updatedTenant.startDate = tenant.startDate
        updatedTenant.endDate = tenant.endDate
        updatedTenant.fullPayments = tenant.fullPayments
        
        return updatedTenant
    }
    
    private func getUpdatedUnitsUsingTempUnits(_ units: [TempSingleUnit], property: Property) -> [SingleUnit] {
        var updatedUnit: [SingleUnit] = []
        for unit in units {
            updatedUnit.append(SingleUnit(id: unit.id,
                                              unitNumber: unit.unitNumber,
                                              property: property,
                                              tenant: getUpdatedTenantUsingTempTenant(tenant: unit.tenant),
                                              numberOfBedrooms: unit.numberOfBedrooms,
                                              numberOfBathrooms: unit.numberOfBathrooms,
                                              isOccupied: unit.isOccupied))
        }
        
        return updatedUnit
    }
    
    func getUpdatedTenantUsingTempTenant(tenant: TempTennant) -> Tennant {
        var updatedTenant = Tennant()
        updatedTenant.id = tenant.id
        updatedTenant.buildingNumber = tenant.buildingNumber
        updatedTenant.unitID = tenant.unitID
        updatedTenant.tennantID = tenant.tennantID
        updatedTenant.name = tenant.name
        updatedTenant.surname = tenant.surname
        updatedTenant.reference = tenant.reference
        updatedTenant.currentAddress = tenant.currentAddress
        updatedTenant.company = tenant.company
        updatedTenant.position = tenant.position
        updatedTenant.monthlyIncome = tenant.monthlyIncome
        updatedTenant.balance = tenant.balance
        updatedTenant.amountDue = tenant.amountDue
        updatedTenant.startDate = tenant.startDate
        updatedTenant.endDate = tenant.endDate
        updatedTenant.fullPayments = tenant.fullPayments
        
        return updatedTenant
    }
    
    func deleteProperty(_ property: Property) {
        dataProvider.delete(property)
    }
    
//    func addTenant(_ tenant: Tennant, to property: Property) {
//        property.
//    }
}

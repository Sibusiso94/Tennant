import Foundation
import SwiftUI

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
    let repository: RealmRepository
    let dataProvider: PropertiesDataProvider
    let unitManager: UnitManager
    let tenantManager: TenantManager
    
    var newProperty = Property()
    
    init(repository: RealmRepository) {
        self.repository = repository
        self.dataProvider = PropertiesDataProvider(repository: repository)
        self.unitManager = UnitManager(repository: repository)
        self.tenantManager = TenantManager(repository: repository)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchProperties() -> [Property] {
        return dataProvider.fetchData()
    }
    
    func fetchPropertyUnits(_ selectedPropertyID: String) -> [SingleUnit] {
        return unitManager.fetchUnits(selectedPropertyID)
    }
    
    func createProperty(newData: NewDataModel, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        newProperty = Property()
        let id = UUID().uuidString
        newProperty = Property(buildingID: id,
                               buildingName: newData.name,
                               buildingAddress: newData.address,
                               numberOfUnits: newData.numberOfUnits)
        
        dispatchGroup.enter()
        guard let numberOfUnits = Int(newData.numberOfUnits) else { return }
        unitManager.generatePropertyUnits(propertyId: newProperty.buildingID, numberOfUnits: numberOfUnits) { unitIds in
            self.newProperty.unitIDs.append(objectsIn: unitIds)  
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.dataProvider.create(self.newProperty)
            completion(true)
        }
    }
    
    func updateProperty(_ property: Property, completion: @escaping () -> Void) {
        dataProvider.update(property)
        completion()
    }
    
    func deleteProperty(_ propertyId: String) {
        dataProvider.delete(propertyId)
        unitManager.deleteUnits(with: propertyId) { unitIds in
            tenantManager.deleteTenants(from: unitIds)
        }
    }
    
    func getTenantCardData() -> [TenantCardModel] {
        let tenants = tenantManager.dataProvider.fetchData()
        let units = unitManager.dataProvider.fetchData()
        let tenantCardData = sortTenantCardData(tenants: tenants, units: units)
        return tenantCardData
    }
    
    private func sortTenantCardData(tenants: [Tennant],
                       units: [SingleUnit]) -> [TenantCardModel] {
        let tenantData = units.flatMap { unit in
            setUpTenantCard(tenants: tenants,
                            unitId: unit.id,
                            unitNumber: unit.unitNumber,
                            isOccupied: unit.isOccupied)
        }
        
        let sortedTenants = tenantData.sorted(by: { $0.unitNumber > $1.unitNumber} )
        return sortedTenants
    }
    
    private func setUpTenantCard(tenants: [Tennant],
                         unitId: String,
                         unitNumber: Int,
                         isOccupied: Bool) -> [TenantCardModel] {
        var updatedTenants: [TenantCardModel] = []
        
        for tenant in tenants {
            if unitId == tenant.unitID {
                updatedTenants.append(TenantCardModel(unitId: unitId, 
                                                      unitNumber: String(unitNumber),
                                                      name: tenant.name,
                                                      amount: String(tenant.amountDue),
                                                      isOccupied: isOccupied))
            } 
        }
        
        return updatedTenants
    }
}

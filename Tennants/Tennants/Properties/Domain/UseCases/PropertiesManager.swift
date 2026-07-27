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

class PropertyUseCase: PropertyUseCaseProtocol {
    let repository: DataSource
    let unitManager: UnitMangerProtocol
    let tenantManager: TenantManagerProtocol
    
    init(
        repository: DataSource,
        unitManager: UnitMangerProtocol,
        tenantManager: TenantManagerProtocol
    ) {
        self.repository = repository
        self.unitManager = unitManager
        self.tenantManager = tenantManager
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func fetchProperties() -> [Property] {
        return repository.readAll(Property.self)
    }
    
    func fetchPropertyUnits(_ selectedPropertyID: String) -> [SingleUnit] {
        return unitManager.fetchUnitsBy(propertyId: selectedPropertyID)
    }
    
    func createProperty(newData: NewDataModel, propertyType: PropertyOptions) async throws {
        let id = UUID().uuidString
        let newProperty = Property(
            buildingID: id,
            buildingName: newData.name,
            buildingAddress: newData.address,
            numberOfUnits: newData.numberOfUnits,
            isSingleUnit: propertyType == .singleUnit ? true : false
        )

        #warning("Update unit number and tenantID")
        #warning("Refactor to get separate units for property")
        let numberOfUnits = Int(newData.numberOfUnits) ?? 1
        let unitId = try await unitManager.addPropertyUnit(
            unit: SingleUnit(
                unitNumber: 1,
                propertyId: newProperty.buildingID,
                tenantID: "",
                numberOfBedrooms: Int(newData.numberOfBedrooms) ?? 1,
                numberOfBathrooms: Int(newData.numberOfBathrooms) ?? 1,
                size: Int(newData.size) ?? 0,
                isOccupied: false
            )
        )
        newProperty.unitIDs.append(unitId)

        try self.repository.create(newProperty)
    }

    #warning("Cannot be returning on delete")
    func deleteProperty(_ propertyId: String) async throws {
        try repository.delete(propertyId, ofType: Property.self)
        try await unitManager.deleteUnits(with: propertyId)
        try await tenantManager.deleteTenants(with: propertyId)
    }
    
    func getTenantCardData(units: [SingleUnit]) -> [UnitCardModel] {
        let tenants = repository.readAll(Tennant.self)
        let tenantCardData = sortTenantCardData(tenants: tenants, units: units)
        return tenantCardData
    }

    private func updateProperty(_ property: Property) async throws {
        try repository.update(property)
    }

    private func sortTenantCardData(tenants: [Tennant],
                       units: [SingleUnit]) -> [UnitCardModel] {
        var tenantData: [UnitCardModel] = []
        for unit in units {
            let data = setUpTenantCard(tenants: tenants,
                                       unitId: unit.id,
                                       unitNumber: unit.unitNumber,
                                       isOccupied: unit.isOccupied)
            tenantData.append(contentsOf: data)
        }
        
        let sortedTenants = tenantData.sorted(by: { $0.unitNumber < $1.unitNumber} )
        return sortedTenants
    }
    
    private func setUpTenantCard(tenants: [Tennant],
                         unitId: String,
                         unitNumber: Int,
                         isOccupied: Bool) -> [UnitCardModel] {
        var updatedTenants: [UnitCardModel] = []
        
        if isOccupied {
            for tenant in tenants {
                if unitId == tenant.unitID {
                    updatedTenants.append(UnitCardModel(unitId: unitId,
                                                          unitNumber: String(unitNumber),
                                                          name: tenant.name,
                                                          amount: String(tenant.amountDue),
                                                          isOccupied: isOccupied))
                }
            }
        } else {
            updatedTenants.append(UnitCardModel(unitId: unitId,
                                                  unitNumber: String(unitNumber),
                                                  name: "",
                                                  amount: "",
                                                  isOccupied: isOccupied))
        }
        
        return updatedTenants
    }
}

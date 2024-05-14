import Foundation
import SwiftUI

enum Field: Int, Hashable {
    case name
    case address
}

enum ErrorMessage: String, Hashable {
    case numberOfUnitsError = "The number of units occupied cannot exceed the number of units."
    case tenantIDError = "Invalid ID number"
}

class LandingViewModel: ObservableObject {
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var tennants: [Tennant] = []
    @Published var selectedUnit: String = ""
    @Published var viewTitle: String = ""
    @Published var buttonTitle: String = ""
    @Published var toastMessage: String = ""
    @Published var numberOfUnitsOccupiedIsHigherThanUnits: Bool = false
    @Published var propertyType: PropertyOptions = .multipleUnits

    let realmRepository: RealmRepository
    @Published var newProperty: Property = Property()
    var newPropertyUnits: [SingleUnit] = []
    @Published var newTennant: Tennant = Tennant()
    @Published var availableUnits: [MenuItemModel] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
    }
}

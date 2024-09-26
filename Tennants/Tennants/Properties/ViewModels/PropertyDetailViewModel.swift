import Foundation

class PropertyDetailViewModel: ObservableObject {
    @Published var selectedTenant = TenantCardModel()
    
    
//    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
//        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
//        return sortedUnits
//    }
}

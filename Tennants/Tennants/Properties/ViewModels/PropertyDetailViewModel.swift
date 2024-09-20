import Foundation

class PropertyDetailViewModel: ObservableObject {
    @Published var units = [SingleUnit]()
    var tenants = [TenantCardModel]()
    
    init(_ tenants: [TenantCardModel]) {
        self.tenants = tenants
    }
    
//    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
//        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
//        return sortedUnits
//    }
}

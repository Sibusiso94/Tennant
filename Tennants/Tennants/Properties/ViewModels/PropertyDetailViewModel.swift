import Foundation

class PropertyDetailViewModel: ObservableObject {
    @Published var units = [SingleUnit]()
    
    init(_ units: [SingleUnit]) {
        self.units = sortUnits(units)
    }
    
    private func sortUnits(_ units: [SingleUnit]) -> [SingleUnit] {
        let sortedUnits = units.sorted { $0.unitNumber < $1.unitNumber }
        return sortedUnits
    }
}

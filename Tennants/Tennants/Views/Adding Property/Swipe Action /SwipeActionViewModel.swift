import Foundation

class SwipeActionViewModel: ObservableObject {
    @Published var displayingUnits: [SingleUnit] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        var units: [SingleUnit] = []
        for item in 0..<4 {
            units.append(SingleUnit(unitNumber: item,
                                               buildingID: "Telesto",
                                               numberOfBedrooms: 1,
                                               numberOfBathrooms: 1,
                                               isAvailable: false))
        }
        
        displayingUnits = units
    }
    
    func getIndex(of unit: SingleUnit) -> Int {
        let index = displayingUnits.firstIndex(where: { currentUint in
            return unit.id == currentUint.id
        }) ?? 0
        
        return index
    }
}

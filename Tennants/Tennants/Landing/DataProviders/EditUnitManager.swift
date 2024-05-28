import Foundation

final class EditUnitManager: ObservableObject {
    @Published var active: Int = 0
    var firstValue: Int = 0
    var lastValue: Int = 0
    var nextScreenIndex: Int = 0
    
    public func next() {
        active += 1
    }
    
    func getLatValue(of units: [SingleUnit]) -> Int {
        if let lastValue = units.last?.UnitNumber {
            return lastValue - 1
        } else {
            return 0
        }
    }
}

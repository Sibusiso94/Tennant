import Foundation

struct TenantCardModel: Identifiable {
    var id = UUID().uuidString
    var unitId: String = ""
    var unitNumber: String = ""
    var name: String = ""
    var surname: String = ""
    var balance: String = "0.0"
    var amount: String = ""
    var isOccupied: Bool = false
}

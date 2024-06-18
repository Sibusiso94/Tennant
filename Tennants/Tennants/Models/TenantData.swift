import Foundation

class TenantData: Codable {
    var id: String
    var date: String
    let reference: String
    var amount: String
}

typealias TennantsData = [TenantData]

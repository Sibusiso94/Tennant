import Foundation

class TenantData: Codable {
    var id: String
    let date: String
    let reference: String
    let amount: String
}

typealias TennantsData = [TenantData]

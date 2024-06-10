import Foundation

class TenantData: Codable {
    let date: String
    let reference: String
    let amount: String
}

typealias TennantsData = [TenantData]

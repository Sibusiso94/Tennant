import Foundation

struct Reference: Codable, Identifiable, Hashable {
    var id: Int?
    var unitId: String
    var tenantId: String
    var reference: String
    var userID: UUID = UUID()

    enum CodingKeys: String, CodingKey {
        case id
        case unitId = "unit_id"
        case tenantId = "tenant_id"
        case reference = "reference"
        case userID = "user_id"
    }
}

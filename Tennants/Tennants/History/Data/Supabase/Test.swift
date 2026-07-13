import Foundation

struct Test: Codable, Identifiable, Hashable {
    var id: Int?
    var createdAt: Date
    var text: String
    var isComplete: Bool
    var userId: UUID

    enum CodingKeys: String, CodingKey {
        case id, text
        case createdAt = "created_at"
        case isComplete = "is_complete"
        case userId = "user_id"
    }
}

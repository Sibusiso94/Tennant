import Foundation
import FirebaseFirestoreSwift

struct Reference: Codable, Identifiable {
    @DocumentID var id: String?
    var references: [String]
}

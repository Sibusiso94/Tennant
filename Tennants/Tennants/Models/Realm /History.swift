import Foundation
import SwiftData

@Model
class TenantData: Identifiable, PersistableModel {
    @Attribute(.unique) var id: String
    var historyId: String
    var date: String
    var reference: String
    var amount: String

    var primaryKey: String { id }

    init(id: String = UUID().uuidString,
         historyId: String,
         date: String,
         reference: String,
         amount: String) {
        self.id = id
        self.historyId = historyId
        self.date = date
        self.reference = reference
        self.amount = amount
    }
}

@Model
class History: Identifiable, PersistableModel {
    @Attribute(.unique) var id: String
    var results: [String]
    var dateCreated: String

    var primaryKey: String { id }

    init(id: String = UUID().uuidString,
         results: [String] = [],
         dateCreated: String = "") {
        self.id = id
        self.results = results
        self.dateCreated = dateCreated
    }
}

class TenantHistory: Identifiable {
    var id: String
    var date: String
    var data: [TenantData]

    init(id: String = UUID().uuidString,
         date: String,
         data: [TenantData]) {
        self.id = id
        self.date = date
        self.data = data
    }
}

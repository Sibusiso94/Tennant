import Foundation
import RealmSwift

class TenantData: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var historyId: String
    @Persisted var date: String
    @Persisted var reference: String
    @Persisted var amount: String

    convenience init(id: String = UUID().uuidString,
                     historyId: String,
                     date: String,
                     reference: String,
                     amount: String) {
        self.init()
        self.id = id
        self.historyId = historyId
        self.date = date
        self.reference = reference
        self.amount = amount
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

class History: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var results: List<String>
    @Persisted var dateCreated: String

    convenience init(id: String = UUID().uuidString,
                     results: List<String> = List<String>(),
                     dateCreated: String = "") {
        self.init()
        self.id = id
        self.results = results
        self.dateCreated = dateCreated
    }

    override class func primaryKey() -> String? {
        "id"
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

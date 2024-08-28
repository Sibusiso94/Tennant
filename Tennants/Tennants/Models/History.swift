import Foundation
import RealmSwift

class TenantData: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var date: String
    @Persisted var reference: String
    @Persisted var amount: String
    
    convenience init(id:  String = UUID().uuidString,
         date: String,
         reference: String,
         amount: String) {
        self.init()
        self.id = id
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
    @Persisted var results: List<TenantData>
    @Persisted var dateCreated: String
    
    convenience init(id: String = UUID().uuidString,
         results: List<TenantData> = List<TenantData>(),
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

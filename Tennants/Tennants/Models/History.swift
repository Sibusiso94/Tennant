import Foundation
import SwiftData

@Model
class TenantData: Identifiable {
    @Attribute(.unique) var id: String
    var date: String
    let reference: String
    var amount: String
    
    init(id:  String = UUID().uuidString,
         date: String,
         reference: String,
         amount: String) {
        self.id = id
        self.date = date
        self.reference = reference
        self.amount = amount
    }
}

@Model
class History: Identifiable {
    @Attribute(.unique) var id: String
    var results: [TenantData]
    var dateCreated: String
    
    init(id: String = UUID().uuidString,
         results: [TenantData] = [],
         dateCreated: String = "") {
        self.id = id
        self.results = results
        self.dateCreated = dateCreated
    }
}

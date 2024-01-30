import Foundation
import RealmSwift

class Tennant: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var buildingNumber: String
    @Persisted var flatNumber: String
    @Persisted var name: String
    @Persisted var surname: String
    @Persisted var company : String
    @Persisted var position: String
    @Persisted var monthlyIncome: Int
    @Persisted var balance: Double
    @Persisted var amountDue: Double
    @Persisted var startDate: String
    @Persisted var endDate: String
    @Persisted var fullPayments: Int
    
    convenience init(id: String = UUID().uuidString, 
                     buildingNumber: String,
                     flatNumber: String,
                     name: String,
                     surname: String,
                     company : String,
                     position: String,
                     monthlyIncome: Int,
                     balance: Double,
                     amountDue: Double,
                     startDate: String,
                     endDate: String,
                     fullPayments: Int) {
        self.init()
        self.buildingNumber = buildingNumber
        self.flatNumber = flatNumber
        self.name = name
        self.surname = surname
        self.company = company
        self.position = position
        self.monthlyIncome = monthlyIncome
        self.balance = balance
        self.amountDue = amountDue
        self.startDate = startDate
        self.endDate = endDate
        self.fullPayments = fullPayments
    }
}

class TennantBuilder {
    var tennant = Tennant()
    
    func works(_ tennant: Tennant) -> TennantJobBuilder {
        TennantJobBuilder(tennant)
    }
    
    func earns(monthlyIncome: Int) -> TennantBuilder {
        tennant.monthlyIncome = monthlyIncome
        return self
    }
    
    func build() -> Tennant {
        return tennant
    }
}

class TennantJobBuilder: TennantBuilder {
    internal init(_ tennant: Tennant) {
        super.init()
        self.tennant = tennant
    }
    
    func at(company: String) -> TennantBuilder {
        tennant.company = company
        return self
    }
    
    func asA(position: String) -> TennantBuilder {
        tennant.position = position
        return self
    }
}

import Foundation
import RealmSwift

class Tennant: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var buildingNumber: String
    @Persisted var unitID: String
    @Persisted var tennantID: String
    @Persisted var name: String
    @Persisted var surname: String
    @Persisted var reference: String
    @Persisted var currentAddress: String
    @Persisted var company : String
    @Persisted var position: String
    @Persisted var monthlyIncome: String
    @Persisted var balance: Double
    @Persisted var amountDue: Double
    @Persisted var startDate: String
    @Persisted var endDate: String
    @Persisted var fullPayments: String
    
    convenience init(id: String = UUID().uuidString,
                     buildingNumber: String = "",
                     unitID: String = "",
                     tennantID: String = "",
                     name: String = "",
                     surname: String = "",
                     reference: String = "",
                     currentAddress: String = "",
                     company : String = "",
                     position: String = "",
                     monthlyIncome: String = "0",
                     balance: Double = 0.0,
                     amountDue: Double = 0.0,
                     startDate: String = "",
                     endDate: String = "",
                     fullPayments: String = "0") {
        self.init()
        self.id = id
        self.buildingNumber = buildingNumber
        self.unitID = unitID
        self.tennantID = tennantID
        self.name = name
        self.surname = surname
        self.reference = reference
        self.currentAddress = currentAddress
        self.company = company
        self.position = position
        self.monthlyIncome = monthlyIncome
        self.balance = balance
        self.amountDue = amountDue
        self.startDate = startDate
        self.endDate = endDate
        self.fullPayments = fullPayments
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class TennantBuilder {
    var tennant = Tennant()
    
    func works(_ tennant: Tennant) -> TennantJobBuilder {
        TennantJobBuilder(tennant)
    }
    
    func earns(monthlyIncome: Int) -> TennantBuilder {
        guard var monthlyIncomeInt = Int(tennant.monthlyIncome) else { return self }
        monthlyIncomeInt = monthlyIncome
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

class MockTenants {
    static let tenants = [Tennant(unitID: "1", name: "John", surname: "Snow", reference: "John Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "2"),
            Tennant(unitID: "3", name: "Jane", surname: "Doe", reference: "Jane Doe", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "4"),
                          Tennant(unitID: "5", name: "Crane", surname: "Moe", reference: "Crane Moe", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "6", name: "Thabo", surname: "FLow", reference: "Thabo Flow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "7"),
            Tennant(unitID: "8"),
            Tennant(unitID: "9"),
            Tennant(unitID: "10")]
}

import Foundation
import SwiftData

@Model
class Tennant: Identifiable {
    @Attribute(.unique) var id: String
    var buildingNumber: String
    var unitID: String
    var tennantID: String
    var name: String
    var surname: String
    var currentAddress: String
    var company : String
    var position: String
    var monthlyIncome: Int
    var balance: Double
    var amountDue: Double
    var startDate: String
    var endDate: String
    var fullPayments: Int
    
    init(id: String = UUID().uuidString,
                     buildingNumber: String = "",
                     unitID: String = "",
                     tennantID: String = "",
                     name: String = "",
                     surname: String = "",
                     currentAddress: String = "",
                     company : String = "",
                     position: String = "",
                     monthlyIncome: Int = 0,
                     balance: Double = 0.0,
                     amountDue: Double = 0.0,
                     startDate: String = "",
                     endDate: String = "",
                     fullPayments: Int = 0) {
        self.id = id
        self.buildingNumber = buildingNumber
        self.unitID = unitID
        self.tennantID = tennantID
        self.name = name
        self.surname = surname
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

class MockTenants {
    static let tenants = [Tennant(unitID: "1", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "2", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "3", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "4", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "5", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "6", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "7", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "8", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "9", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "10", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0),
            Tennant(unitID: "11", name: "John", surname: "Snow", balance: 0.0, amountDue: 0.0)]
}

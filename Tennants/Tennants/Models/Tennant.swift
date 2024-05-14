import Foundation

//class AllTennants: Object, Identifiable {
//    @Persisted(primaryKey: true) var id: String
//    @Persisted var tennants: List<Tennant>
//   
//    func saveUser() {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(self, update: .modified)
//            }
//        } catch {
//            // add a completion to handle error
//            print("Failed to add user: \(error)")
//        }
//    }
//}

class Tennant: Identifiable {
    var id: String
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

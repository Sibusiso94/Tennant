import Foundation

struct Tennant {
    var id = ""
    var flatID = ""
    var name = ""
    var surname = ""
    var company = ""
    var position = ""
    var annualIncome = 0
    var balance = 0
    var amountDue = 0
    var startDate = ""
    var endDate = ""
}

class TennantBuilder {
    var tennant = Tennant()
    
    func works(_ tennant: Tennant) -> TennantJobBuilder {
        TennantJobBuilder(tennant)
    }
    
    func earns(annualIncome: Int) -> TennantBuilder {
        tennant.annualIncome = annualIncome
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

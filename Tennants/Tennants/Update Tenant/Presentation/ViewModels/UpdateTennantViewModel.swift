import Foundation

@Observable
class UpdateTennantViewModel {
    private let useCase: TenantProprtyDetailsProtocol

    var newTennants = [Tennant]()
    var rentAmount: Int = 1500
    
    var amountAdded: String = ""
    var selectedTennant = Tennant()
    var numberOfMonthsPassed: Int = 0
    var endDate: Date


    init(useCase: TenantProprtyDetailsProtocol) {
        self.useCase = useCase
        self.endDate = Date.now
//        mapTennantsToArray()
//        getTennantByMostDebt()
    }

    convenience init() {
        let useCase = DIContainer.shared.resolve(TenantProprtyDetailsProtocol.self)

        self.init(useCase: useCase)
    }

    func getInitials(name: String, surname: String) -> String {
        guard let firstLetter = name.first else { return "" }
        guard let secondLetter = surname.first else { return "" }

        return "\(String(describing: firstLetter))\(String(describing: secondLetter))"
    }

    func getPropertyName(from propertyId: String) -> String {
        useCase.getPropertyName(propertyId: propertyId)
    }

    func getUnitNumber(from tenantId: String) -> String {
        useCase.getUnitName(tenantId: tenantId)
    }

    func formatDate(with date: Date) -> String {
        return date.formatted(date: .abbreviated, time: .omitted)
    }

    func isTenantActive(date: Date) -> Bool {
        if date > Date.now {
            return true
        } else {
            return false
        }
    }

    func getNumberOfMonthsPassed(startDate: String, endDate: Date) {
        let calandar = Calendar.current
        #warning("Make sure start date is not ahead of current date")
        let components = calandar.dateComponents([.month], from: startDate.getStringAsDate(), to: endDate)
        guard let monthsPassed = components.month else { return }
        numberOfMonthsPassed = monthsPassed
    }
    
    #warning("Add and create tests")
    func isAFutureDate(startDate: Date, endDate: Date) -> Bool {
        if startDate > endDate {
            return true
        } else {
            return false
        }
    }
    
    func getPaymentHistoryPercentage(numberOfMonthsPassed: Int, numberOfFullPayments: Int) -> Double {
        let paymentHistoryPercentage = Double(numberOfFullPayments) / Double(numberOfMonthsPassed)
        let roundedPaymentHistoryPercentage = (round(10 * paymentHistoryPercentage) / 10)
        return roundedPaymentHistoryPercentage
    }
    
    func getPercentage(percentageDouble: Double) -> String {
        if percentageDouble == 0.0 {
            let percentageString = Int(percentageDouble * 100)
            return "\(percentageString)%"
        } else {
            return "0%"
        }
    }
    
    func paidInFull() {
        if var payment = Int(selectedTennant.fullPayments) {
            payment += 1
            selectedTennant.fullPayments = String(payment)
        }
    }
    
    func notPaidInFull(with amount: Double) {
        selectedTennant.amountDue += amount
    }
}

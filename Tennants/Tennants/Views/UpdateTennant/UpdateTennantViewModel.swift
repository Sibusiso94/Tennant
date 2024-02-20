import Foundation
import RealmSwift

class UpdateTennantViewModel: ObservableObject, PaymentHistoryCalculatable, AmountPayableRepository {
    var realmRepository: RealmRepository
    var newTennants = [Tennant]()
    var rentAmount: Int = 1500
    
    @Published var amountAdded: String = ""
    @Published var selectedTennant = Tennant()
    @Published var numberOfMonthsPassed: Int = 0
    @Published var endDate: Date
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
        self.endDate = Date.now
//        mapTennantsToArray()
//        getTennantByMostDebt()
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
        let percentageString = Int(percentageDouble * 100)
        return "\(percentageString)%"
    }
    
    func paidInFull() {
        selectedTennant.fullPayments += 1
    }
    
    func notPaidInFull(with amount: Double) {
        selectedTennant.amountDue += amount
    }
}

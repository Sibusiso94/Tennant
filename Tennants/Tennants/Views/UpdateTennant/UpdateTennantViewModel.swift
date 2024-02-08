import Foundation
import RealmSwift

class UpdateTennantViewModel: ObservableObject, TennantRepository, PaymentHistoryCalculatable, AmountPayableRepository {
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
        mapTennantsToArray()
        getTennantByMostDebt()
    }
    
    func mapTennantsToArray() {
        newTennants = self.realmRepository.tennants.map({ Tennant(buildingNumber: $0.buildingNumber,
                                                            flatNumber: $0.flatNumber,
                                                            name: $0.name,
                                                            surname: $0.surname,
                                                            company: $0.company,
                                                            position: $0.position,
                                                            monthlyIncome: $0.monthlyIncome,
                                                            balance: $0.balance,
                                                            amountDue: $0.amountDue,
                                                            startDate: $0.startDate,
                                                            endDate: $0.endDate,
                                                            fullPayments: $0.fullPayments) })
        print(newTennants)
    }
    
    func updateTennant() {
        let index = newTennants.firstIndex(where: { $0.id == selectedTennant.id}) ?? 0
        newTennants[index] = selectedTennant
        
//        try? realmRepository.update(insertions: newTennants)
    }
    
    func deleteTennant() {
        if let tennatToDelete = newTennants.first(where: { tennant in
            tennant.id == selectedTennant
        }) {
            try? realmRepository.delete(tennatToDelete)
        }
    }
    
    func getTennantByMostDebt() {
        let sortedTennants = realmRepository.tennants.sorted(by: {$0.amountDue > $1.amountDue})
        if let sortedTennant = sortedTennants.first {
            selectedTennant = sortedTennant
        }
    }
    
    func addTennant() {
//        realmRepository.add(selectedTennant, to: realmRepository.realm)
        try! realmRepository.update(insertions: [selectedTennant])
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

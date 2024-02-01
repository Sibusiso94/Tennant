import Foundation
import RealmSwift

class UpdateTennantViewModel: ObservableObject, TennantRepository {
    var realmRepository: RealmRepository
    var newTennants = [Tennant]()
    
    @Published var amountAdded: String = ""
    @Published var selectedTennant = Tennant()
    @Published var numberOfMonthsPassed: Int = 0
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
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
    }
    
    func updateTennant() {
        let index = newTennants.firstIndex(where: { $0.id == selectedTennant.id}) ?? 0
        newTennants[index] = selectedTennant
        
//        try? realmRepository.update(insertions: newTennants)
    }
    
    func deleteTennant() {
        try? realmRepository.delete(selectedTennant)
    }
    
    func getTennantByMostDebt() {
        let sortedTennants = realmRepository.tennants.sorted(by: {$0.amountDue > $1.amountDue})
        if let sortedTennant = sortedTennants.first {
            selectedTennant = sortedTennant
        }
    }
    
    func addTennant() {
        realmRepository.add(selectedTennant)
    }
    
    func getNumberOfMonthsPassed(startDate: String) {
        let endDate = Date.now
        let calandar = Calendar.current
        let components = calandar.dateComponents([.month], from: startDate.getStringAsDate(), to: endDate)
        guard let monthsPassed = components.month else { return }
        numberOfMonthsPassed = monthsPassed
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
}

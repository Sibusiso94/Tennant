import Foundation

protocol TennantAddable {
    func addTennant(selectedTennant: Tennant)
}

protocol TennantUpdatable {
    func updateTennant(newTennants: inout [Tennant], selectedTennant: Tennant)
}

protocol TennantDeletable {
    func deleteTennant(newTennants: inout [Tennant], selectedTennant: Tennant)
}

protocol TennantByMostDebtable {
    func getTennantByMostDebt(selectedTennant: inout Tennant)
}

protocol TennantRepository: TennantAddable,
                                TennantUpdatable,
                                TennantDeletable,
                                TennantByMostDebtable {
    var realmRepository: RealmRepository { get }
}

protocol PaymentHistoryCalculatable {
    func getNumberOfMonthsPassed(startDate: String, endDate: Date)
    func getPaymentHistoryPercentage(numberOfMonthsPassed: Int, numberOfFullPayments: Int) -> Double
    func getPercentage(percentageDouble: Double) -> String
}

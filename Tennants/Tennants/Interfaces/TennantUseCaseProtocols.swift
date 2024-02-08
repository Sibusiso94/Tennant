import Foundation

protocol TennantAddable {
    func addTennant()
}

protocol TennantUpdatable {
    func updateTennant()
}

protocol TennantDeletable {
    func deleteTennant()
}

protocol TennantByMostDebtable {
    func getTennantByMostDebt()
}

protocol TennantRepository: TennantAddable,
                                TennantUpdatable,
                                TennantDeletable,
                                TennantByMostDebtable,
                                PaymentHistoryCalculatable,
                                AmountPayableRepository {
    var realmRepository: RealmRepository { get }
}

protocol PaymentHistoryCalculatable {
    func getNumberOfMonthsPassed(startDate: String, endDate: Date)
    func getPaymentHistoryPercentage(numberOfMonthsPassed: Int, numberOfFullPayments: Int) -> Double
    func getPercentage(percentageDouble: Double) -> String
}

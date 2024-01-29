import Foundation

protocol FullAmountPayable {
    var rentAmount: Int { get }
    func paidInFull()
}

protocol FullAmountNotPayable {
    func notPaidInFull(with amount: Int)
}

protocol AmountPayableRepository: FullAmountPayable, FullAmountNotPayable { }

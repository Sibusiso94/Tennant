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
                                TennantByMostDebtable { }

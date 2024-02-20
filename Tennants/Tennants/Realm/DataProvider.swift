import Foundation

class DataProvider: TennantRepository {
    let realmRepository = RealmRepository()
    func mapTennantsToArray(newTennants: inout [Tennant]) {
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
    
    func updateTennant(newTennants: inout [Tennant], selectedTennant: Tennant) {
        let index = newTennants.firstIndex(where: { $0.id == selectedTennant.id}) ?? 0
        newTennants[index] = selectedTennant
        
//        try? realmRepository.update(insertions: newTennants)
    }
    
    func deleteTennant(newTennants: inout [Tennant], selectedTennant: Tennant) {
        if let tennatToDelete = newTennants.first(where: { tennant in
            tennant.id == selectedTennant
        }) {
            try? realmRepository.delete(tennatToDelete)
        }
    }
    
    func getTennantByMostDebt(selectedTennant: inout Tennant) {
        let sortedTennants = realmRepository.tennants.sorted(by: {$0.amountDue > $1.amountDue})
        if let sortedTennant = sortedTennants.first {
            selectedTennant = sortedTennant
        }
    }
    
    func addTennant(selectedTennant: Tennant) {
        try! realmRepository.update(insertions: [selectedTennant])
    }
}

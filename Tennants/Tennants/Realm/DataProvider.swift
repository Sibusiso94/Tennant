import Foundation

class DataProvider: TennantRepository {
    let realmRepository = RealmRepository()
    
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

import Foundation

enum CalculateViewStates {
    case updateTennant
    case uploadFile
}

class CalculateViewViewModel: ObservableObject, AmountPayableRepository {
    @Published var showAlert: Bool = false
    @Published var showCalculateView: CalculateViewStates = .updateTennant
    
    func paidInFull() {
        //
    }
    
    func notPaidInFull(with amount: Int) {
        //
    }
}

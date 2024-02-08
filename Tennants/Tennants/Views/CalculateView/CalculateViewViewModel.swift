import Foundation

enum CalculateViewStates {
    case updateTennant
    case uploadFile
}

class CalculateViewViewModel: ObservableObject, AmountPayableRepository {
    var rentAmount: Int
    
    @Published var showAlert: Bool
    @Published var showCalculateView: CalculateViewStates
    
    init(rentAmount: Int = 1500,
         showAlert: Bool = false,
         showCalculateView: CalculateViewStates = .updateTennant) {
        self.rentAmount = rentAmount
        self.showAlert = showAlert
        self.showCalculateView = showCalculateView
    }
    
    func paidInFull() {
        //
    }
    
    func notPaidInFull(with amount: Double) {
        //
    }
}

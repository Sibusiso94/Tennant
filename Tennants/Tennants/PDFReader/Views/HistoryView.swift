import SwiftUI
import SwiftData
import MyLibrary

struct HistoryView: View {
    var history: History
    
    var body: some View {
        VStack {
            Text(history.dateCreated)
            ForEach(history.results, id: \.id) { result in
                UserDetailsCard(reference: result.reference,
                                amount: result.amount,
                                date: result.date,
                                isCompletePayment: true)
                .foregroundStyle(Color.black)
            }
        }
    }
}

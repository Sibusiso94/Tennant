import SwiftUI
import SwiftData
import MyLibrary

struct HistoryView: View {
    var history: History
    
    var body: some View {
        VStack {
            Text(history.dateCreated)
                .foregroundStyle(.black.opacity(0.7))
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

import SwiftUI
import MyLibrary

struct HistoryView: View {
    var heading: String
    var tenantInfo: [TenantData]

    var body: some View {
        VStack {
            Text(heading)
                .foregroundStyle(.black.opacity(0.7))
            ForEach(tenantInfo, id: \.id) { result in
                UserDetailsCard(reference: result.reference,
                                amount: result.amount,
                                date: result.date,
                                isCompletePayment: true)
                .foregroundStyle(Color.black)
            }
        }
    }
}

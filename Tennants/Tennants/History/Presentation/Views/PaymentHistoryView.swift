import SwiftUI

/// Displays the parsed tenant payment history. Extracted from `FileUploaderView`
/// so it can be pushed as a standalone destination by the `HistoryCoordinator`.
struct PaymentHistoryView: View {
    let history: [TenantHistory]

    var body: some View {
        ZStack {
            Color("PastelGrey")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(history) { entry in
                        HistoryView(heading: entry.date, tenantInfo: entry.data)
                    }
                }
            }
        }
    }
}

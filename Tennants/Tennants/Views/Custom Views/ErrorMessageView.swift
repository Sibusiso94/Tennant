import SwiftUI

struct ErrorMessageView: View {
    var errorMessage: ErrorMessage
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
            Text(errorMessage.rawValue)
                .font(.system(size: 15))
        }
        .foregroundStyle(.pink)
        .opacity(0.7)
        .padding(.horizontal)
    }
}

#Preview {
    ErrorMessageView(errorMessage: ErrorMessage.numberOfUnitsError)
}

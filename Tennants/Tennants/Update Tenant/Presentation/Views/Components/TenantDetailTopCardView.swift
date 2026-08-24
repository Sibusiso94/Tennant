import SwiftUI

struct TenantDetailTopCardView: View {

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color("PastelBlue"))
                    .frame(width: 100, height: 100)

                Text("JS")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(Color("DarkPastelBlue"))
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("John")
                    .font(.system(size: 28, weight: .semibold))
                    .bold()
                Text("Snow")
                    .font(.system(size: 28))

                HStack(spacing: 8) {
                    Circle()
                        .fill(.green)
                        .frame(width: 10, height: 10)

                    Text("Active")
                        .font(.subheadline)
                        .foregroundStyle(.green)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Color.green.opacity(0.12)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.vertical)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

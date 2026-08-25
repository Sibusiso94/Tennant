import SwiftUI

struct TenantDetailTopCardView: View {
    let initial: String
    let name: String
    let surname: String
    let isActive: Bool

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color("PastelBlue"))
                    .frame(width: 100, height: 100)

                Text(initial)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(Color("DarkPastelBlue"))
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 28, weight: .semibold))
                    .bold()
                Text(surname)
                    .font(.system(size: 28))

                HStack(spacing: 8) {
                    Circle()
                        .fill(isActive ? .green : .red)
                        .frame(width: 10, height: 10)

                    Text(isActive
                         ? TenantStrings.TenancyPeriod.isActive.rawValue
                         : TenantStrings.TenancyPeriod.isNotActive.rawValue
                    )
                    .font(.subheadline)
                    .foregroundStyle(isActive ? .green : .red)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    isActive ? Color.green.opacity(0.12) : Color.red.opacity(0.12)
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

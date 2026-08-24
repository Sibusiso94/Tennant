import SwiftUI

struct TenantDetailInfoCardView: View {
    var image: String
    var mainTitle: String
    var details: [(title: String, name: String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color("PastelBlue"))
                        .frame(width: 40, height: 40)

                    Image(systemName: image)
                        .font(.system(size: 18))
                        .foregroundStyle(Color("DarkPastelBlue"))
                }

                Text(mainTitle)
                    .font(.system(size: 20, weight: .semibold))

                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)

            ForEach(Array(details.enumerated()), id: \.offset) { _, detail in
                infoDetails(title: detail.title, name: detail.name)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    @ViewBuilder
    func infoDetails(title: String, name: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.secondary)

                Spacer()

                Text(name)
            }

            Divider()
        }
        .padding(.horizontal)
    }
}

import SwiftUI

struct UnitTopCardView: View {
    var imageNumber: String
    var unitNumber: String
    var address: String
    var isOccupied: Bool

    init(imageNumber: String,
         unitNumber: String,
         address: String,
         isOccupied: Bool) {
        self.imageNumber = imageNumber
        self.unitNumber = unitNumber
        self.address = address
        self.isOccupied = isOccupied
    }

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image("room\(imageNumber)")
                    .resizable()
                    .frame(width: 120, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 12))


                VStack(alignment: .leading) {
                    Text("Room \(unitNumber)")
                        .bold()

                    Text(address)
                        .foregroundStyle(.secondary)

                    HStack {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(isOccupied ? Color.green : Color.red)
                        Text(isOccupied ? "Occupied" : "Not occupied")
                            .font(.system(size: 15))
                            .fontWeight(.light)
                    }
                }
                .foregroundStyle(Color.black.opacity(0.7))

                Spacer()

                Image(systemName: "chevron.right")
                    .bold()
                    .foregroundStyle(Color("DarkPastelBlue"))
            }
            .padding()
        }
        .background {
            Color.white
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
    }
}

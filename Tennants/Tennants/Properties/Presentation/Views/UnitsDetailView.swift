import SwiftUI

public struct UnitDetailView: View {
    var title: String
    var image: Image
    var complexName: String?
    var address: String
    var bedrooms: String
    var bathrooms: String
    var size: String?

    public init(title: String,
                image: Image,
                complexName: String? = nil,
                address: String,
                bedrooms: String,
                bathrooms: String,
                size: String? = nil) {
        self.title = title
        self.image = image
        self.complexName = complexName
        self.address = address
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.size = size
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .padding(.horizontal)

            image
                .resizable()
                .frame(height: 250)

            VStack(alignment: .leading) {
                if let complexName {
                    Text(complexName)
                        .font(.title3)
                }

                Text(address)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.horizontal)

            HStack(spacing: 16) {
                Template(image: "bed.double", text: "\(bedrooms) Beds")
                Template(image: "shower", text: "\(bathrooms) Bath")
                Template(image: "arrow.down.backward.and.arrow.up.forward.square", text: size ?? "-")
            }
            .padding(.vertical)
            .padding(.horizontal)

            Spacer()
        }
    }
}

struct Template: View {
    var image: String
    var text: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .opacity(0.8)
            Text(text)
                .foregroundStyle(Color.secondary)
        }
    }
}

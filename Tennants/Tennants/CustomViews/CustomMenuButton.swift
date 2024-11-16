import SwiftUI

public struct CustomMenuButton: View {
    var title1: String
    var title2: String
    var image1: String
    var image2: String
    var isOccupied: Bool
    var option1Action: () -> Void
    var option2Action: () -> Void

    public init(title1: String = "Edit",
                title2: String = "Delete",
                image1: String = "pencil",
                image2: String = "trash",
                isOccupied: Bool = true,
                option1Action: @escaping () -> Void,
                option2Action: @escaping () -> Void) {
        self.title1 = title1
        self.title2 = title2
        self.image1 = image1
        self.image2 = image2
        self.isOccupied = isOccupied
        self.option1Action = option1Action
        self.option2Action = option2Action
    }

    public var body: some View {
        Menu {
            Button {
                option1Action()
            } label: {
                Label(title1, systemImage: image1)
            }

            if isOccupied {
                Button(role: .destructive) {
                    option2Action()
                } label: {
                    Label(title2, systemImage: image2)
                }
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
}

import SwiftUI

struct MenuItemModel {
    var id: String
    var name: String
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}

struct CustomMenu: View {
    @Binding var selectedItem: String
    var items: [MenuItemModel]
    var action: (String) -> Void
    
    init(selectedItem: Binding<String>,
         items: [MenuItemModel],
         action: @escaping (String) -> Void) {
        self._selectedItem = selectedItem
        self.items = items
        self.action = action
    }
    
    var body: some View {
        VStack {
            Menu(items.first?.name ?? "") {
                ForEach(items, id: \.id) { item in
                    Button {
                        selectedItem = item.id 
                        action(selectedItem)
                    } label: {
                        Text("\(item.name)")
                    }
                    .customHorizontalPadding(isButton: true)
                }
            }
            .padding()
            .customHorizontalPadding(isButton: true)
        }
    }
}

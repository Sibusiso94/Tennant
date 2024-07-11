import SwiftUI
import SwiftData

struct ContentView: View {
    let modelContext: ModelContext
    var body: some View {
        MainAppView(modelContext: modelContext)
    }
}

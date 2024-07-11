import SwiftData
import SwiftUI
import Firebase

@main
struct TennantsApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        FirebaseApp.configure()
        do {
            container = try ModelContainer(for: Property.self, SingleUnit.self, Tennant.self, History.self, TenantData.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}

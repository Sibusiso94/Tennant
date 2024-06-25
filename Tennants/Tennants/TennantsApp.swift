import SwiftData
import SwiftUI
import Firebase

@main
struct TennantsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Property.self, SingleUnit.self, Tennant.self])
    }
    
    init() {
        FirebaseApp.configure()
    }
}

import SwiftUI

@main
struct TennantsApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = Migrator()
            ContentView()
        }
    }
}

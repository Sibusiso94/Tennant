import SwiftUI
import SwiftData

@main
struct TennantsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataRepository.sharedContainer)
    }
    
    init() {
    }
}

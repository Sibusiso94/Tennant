import SwiftUI

@main
struct TennantsApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}

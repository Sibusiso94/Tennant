import Foundation

/// Schema migrations are handled by SwiftData's `ModelContainer` (see
/// `SwiftDataRepository.sharedContainer`). This type is retained as a no-op
/// hook for any future versioned-schema migration logic.
class Migrator {
    init() {
        updateSchema()
    }

    func updateSchema() {
        // No-op: SwiftData performs lightweight migrations automatically.
    }
}

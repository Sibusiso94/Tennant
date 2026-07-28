import SwiftUI

/// Abstraction every feature coordinator conforms to.
///
/// A coordinator is the single object that owns navigation state for a feature.
/// It exposes one intent-based entry point, `route(to:)`, which view models call
/// to request navigation. The coordinator translates the abstract `Route` into
/// concrete state mutations (pushing onto a `NavigationStack` path, presenting a
/// sheet, …) that a matching `CoordinatorView` renders.
///
/// It is class-bound (`AnyObject`) and `ObservableObject` so views can observe
/// its published navigation state, and so view models can hold a `weak`
/// reference without creating a retain cycle.
@MainActor
protocol Coordinator<Route>: ObservableObject, AnyObject {
    associatedtype Route

    func route(to route: Route) async throws
}

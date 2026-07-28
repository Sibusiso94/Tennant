import SwiftUI

/// Single place that knows how to construct coordinators, view models and views
/// and wire their dependencies together.
///
/// Keeping construction here means `CoordinatorView`s never need to know how a
/// screen is assembled — they just ask the factory. View models continue to
/// resolve their domain dependencies from the `DIContainer`; the factory's only
/// extra responsibility is injecting the coordinator so a screen can request
/// navigation.
///
/// Feature-specific builders are declared in each feature's coordinator file as
/// `extension AppFactory`, keeping this core type small and each feature's
/// assembly logic colocated with the feature.
@MainActor
final class AppFactory {

    // MARK: Root

    /// The top-level tab view. Each tab hosts a feature's coordinator view.
    func makeMainTabView() -> some View {
        TenantTabView(factory: self)
    }

    // MARK: Feature entry points

    func makePropertiesCoordinatorView() -> some View {
        PropertiesCoordinatorView(factory: self)
    }

    func makeTenantsCoordinatorView() -> some View {
        TenantsCoordinatorView(factory: self)
    }

    func makeHistoryCoordinatorView() -> some View {
        HistoryCoordinatorView(factory: self)
    }
}

import SwiftUI

/// Owns the `NavigationStack` for the Properties tab, binds it to the
/// coordinator's `path`, and resolves each destination / sheet to a concrete
/// view through the factory. The coordinator is retained here via `@StateObject`
/// for the lifetime of the tab.
struct PropertiesCoordinatorView: View {
    @StateObject private var coordinator: PropertiesCoordinator
    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
        _coordinator = StateObject(wrappedValue: PropertiesCoordinator(factory: factory))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            factory.makePropertiesView(viewModel: coordinator.viewModel)
                .navigationDestination(for: PropertiesDestination.self) { destination in
                    switch destination {
                    case .propertyOptions:
                        factory.makePropertyOptionsView(viewModel: coordinator.viewModel)
                    case .addProperty:
                        factory.makeAddPropertyView(viewModel: coordinator.viewModel)
                    case .propertyDetail:
                        factory.makePropertyDetailView(coordinator: coordinator)
                    case .unitDetail:
                        factory.makeUnitDetailView(coordinator: coordinator)
                    case .addTenant:
                        factory.makeAddTenantView(coordinator: coordinator)
                    }
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    switch sheet {
                    case .editUnit:
                        factory.makeEditUnitView(coordinator: coordinator)
                    }
                }
        }
    }
}

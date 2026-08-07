import SwiftUI
import Combine
import MyLibrary

// MARK: - Routes

/// The navigation *intents* view models can express for the Properties flow.
/// This is the vocabulary the `PropertiesViewModel` speaks; it says nothing
/// about *how* navigation happens (push vs. sheet).
enum PropertiesRoute {
    case propertyOptions
    case addProperty
    case propertyDetail
    case unitDetail
    case addTenant
    case editUnit
    case popToRoot
}

/// Destinations pushed onto the `NavigationStack`. The concrete data each screen
/// needs lives on the coordinator's view models, so these cases stay lightweight
/// and trivially `Hashable`.
enum PropertiesDestination: Hashable {
    case propertyOptions
    case addProperty
    case propertyDetail
    case unitDetail
    case addTenant
}

/// Modally presented destinations. `.sheet(item:)` requires `Identifiable`.
enum PropertiesSheet: Identifiable {
    case editUnit

    var id: String {
        switch self {
        case .editUnit: return "editUnit"
        }
    }
}

// MARK: - Coordinator

/// Owns the navigation state for the Properties tab and the view models shared
/// across the flow. It builds its own root view model (injecting itself) and a
/// `PropertyDetailViewModel` that both the detail and unit screens read from.
@MainActor
final class PropertiesCoordinator: Coordinator {
    let factory: AppFactory

    private(set) var viewModel: PropertiesViewModel!
    let detailViewModel: PropertyDetailViewModel

    @Published var path: [PropertiesDestination] = []
    @Published var sheet: PropertiesSheet?

    init(factory: AppFactory) {
        self.factory = factory
        self.detailViewModel = factory.makePropertyDetailViewModel()
        self.viewModel = factory.makePropertiesViewModel(coordinator: self)
    }

    func route(to route: PropertiesRoute) async throws {
        switch route {
        case .propertyOptions:
            path.append(.propertyOptions)
        case .addProperty:
            path.append(.addProperty)
        case .propertyDetail:
            path.append(.propertyDetail)
        case .unitDetail:
            // Load the tapped unit into the shared detail view model before the
            // unit screen appears.
            if let unitID = viewModel.selectedUnitCard?.unitId {
                detailViewModel.fetchUnit(unitID)
            }
            path.append(.unitDetail)
        case .addTenant:
            path.append(.addTenant)
        case .editUnit:
            sheet = .editUnit
        case .popToRoot:
            path.removeAll()
        }
    }
}

// MARK: - Factory

extension AppFactory {
    func makePropertiesViewModel(coordinator: any Coordinator<PropertiesRoute>) -> PropertiesViewModel {
        let viewModel = PropertiesViewModel()
        viewModel.coordinator = coordinator
        return viewModel
    }

    func makePropertyDetailViewModel() -> PropertyDetailViewModel {
        PropertyDetailViewModel()
    }

    @ViewBuilder
    func makePropertiesView(viewModel: PropertiesViewModel) -> some View {
        PropertiesView(viewModel: viewModel)
    }

    @ViewBuilder
    func makePropertyOptionsView(viewModel: PropertiesViewModel) -> some View {
        PropertyOptionsView { selectedOption in
            viewModel.managePropertyOptions(selectedOption)
        }
    }

    @ViewBuilder
    func makeAddPropertyView(viewModel: PropertiesViewModel) -> some View {
        AddPropertyView(viewModel: viewModel) {
            viewModel.addProperty()
        }
    }

    @ViewBuilder
    func makePropertyDetailView(coordinator: PropertiesCoordinator) -> some View {
        PropertyDetailView(
            viewModel: coordinator.viewModel,
            detailViewModel: coordinator.detailViewModel
        )
    }

    @ViewBuilder
    func makeUnitDetailView(coordinator: PropertiesCoordinator) -> some View {
        let propertyViewModel = coordinator.viewModel!
        if let unit = coordinator.detailViewModel.unit {
            UnitDetailViewContainer(
                propertyViewModel: propertyViewModel,
                viewModel: coordinator.detailViewModel,
                unit: unit,
                complexName: propertyViewModel.selectedProperty.buildingName,
                buildingId: propertyViewModel.selectedProperty.buildingID,
                address: propertyViewModel.selectedProperty.buildingAddress,
                tenant: propertyViewModel.selectedTenant,
                unitImage: Image(propertyViewModel.unitImage ?? "house")
            )
        }
    }

    @ViewBuilder
    func makeAddTenantView(coordinator: PropertiesCoordinator) -> some View {
        let propertyViewModel = coordinator.viewModel!
        let detailViewModel = coordinator.detailViewModel
        if let unit = detailViewModel.unit {
            AddTenantView(propertyId: propertyViewModel.selectedProperty.buildingID, unitId: unit.id)
        }
//        { tenant in
//            guard let unit = detailViewModel.unit else { return }
//            detailViewModel.addTenant(
//                tenant,
//                propertyID: propertyViewModel.selectedProperty.buildingID,
//                unitId: unit.id
//            )
//        }
    }

    @ViewBuilder
    func makeEditUnitView(coordinator: PropertiesCoordinator) -> some View {
        let propertyViewModel = coordinator.viewModel!
        let detailViewModel = coordinator.detailViewModel
        // Presented as a sheet: a sheet is its own presentation context, so it
        // needs its own NavigationStack to render the title / Cancel toolbar.
        NavigationStack {
//            AddPropertyView(viewModel: propertyViewModel) {
//                guard let unit = detailViewModel.unit else { return }
//                detailViewModel.updateUnit(
//                    unitId: unit.id,
//                    tenantId: propertyViewModel.selectedTenant?.id ?? ""
//                )
//            }
        }
    }
}

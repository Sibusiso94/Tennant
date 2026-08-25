import Foundation
import Swinject

final class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }
        .inObjectScope(.container)

        container.register(DataSource.self) { _ in
            SwiftDataRepository()
        }
        .inObjectScope(.container)

        container.register(HistoryManagable.self) { resolver in
            guard let dataSource = resolver.resolve(DataSource.self) else {
                preconditionFailure("Failed to register DataSource")
            }

            return HistoryManager(repository: dataSource)
        }
        .inObjectScope(.container)

        container.register(SupabaseNetworkingProtocol.self) { _ in
            SupabaseNetworking()
        }
        .inObjectScope(.container)

        container.register(ReferencesManagable.self) { resolver in
            guard let supabase = resolver.resolve(SupabaseNetworkingProtocol.self) else {
                preconditionFailure("Failed to register SupabaseNetworkingProtocol")
            }

            return ReferencesManager(supabaseRepository: supabase)
        }

        container.register(APIManager.self) { resolver in
            guard let networkService = resolver.resolve(NetworkServiceProtocol.self) else {
                preconditionFailure("Failed to register NetworkServiceProtocol")
            }

            return ApiDataManager(networkingManager: networkService)
        }

        container.register(TenantPaymentProtocol.self) { resolver in
            guard let apiManager = resolver.resolve(APIManager.self) else {
                preconditionFailure("Failed to register APIManager")
            }
            guard let historyManager = resolver.resolve(HistoryManagable.self) else {
                preconditionFailure("Failed to register HistoryManagable")
            }
            guard let supabase = resolver.resolve(SupabaseNetworkingProtocol.self) else {
                preconditionFailure("Failed to register SupabaseNetworkingProtocol")
            }

            return TenantPaymentUseCase(
                apiManager: apiManager,
                historManager: historyManager,
                supabase: supabase
            )
        }

        container.register(UnitMangerProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(DataSource.self) else {
                preconditionFailure("Failed to register DataSource")
            }

            return UnitManager(repository: dataSource)
        }

        container.register(TenantManagerProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(DataSource.self) else {
                preconditionFailure("Failed to register DataSource")
            }

            return TenantManager(repository: dataSource)
        }

        container.register(TenantProprtyDetailsProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(DataSource.self) else {
                preconditionFailure("Failed to register DataSource")
            }

            return TenantManager(repository: dataSource)
        }

        container.register(PropertyUseCaseProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(DataSource.self) else {
                preconditionFailure("Failed to register DataSource")
            }

            guard let unitManager = resolver.resolve(UnitMangerProtocol.self) else {
                preconditionFailure("Failed to register UnitMangerProtocol")
            }

            guard let tenantManager = resolver.resolve(TenantManagerProtocol.self) else {
                preconditionFailure("Failed to register TenantManagerProtocol")
            }

            return PropertyUseCase(
                repository: dataSource,
                unitManager: unitManager,
                tenantManager: tenantManager
            )
        }
    }
}

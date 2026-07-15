import Foundation
import Swinject

final class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }
        .inObjectScope(.container)

        container.register(HistoryManagable.self) { _ in
            HistoryManager(repository: SwiftDataRepository())
        }
        .inObjectScope(.container)

        container.register(SupabaseNetworkingProtocol.self) { _ in
            SupabaseNetworking()
        }
        .inObjectScope(.container)

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
    }
}

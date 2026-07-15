import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()

    private let assembler: Assembler

    var resolver: Resolver {
        assembler.resolver
    }

    private init(assemblies: [Assembly] = [AppAssembly()]) {
        assembler = Assembler(assemblies)
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = resolver.resolve(serviceType) else {
            preconditionFailure("Dependency \(serviceType) is not registered in the DI container.")
        }
        return service
    }
}

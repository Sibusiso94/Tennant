// MARK: - Mocks generated from file: 'History/Data/APIManagers/APIManager.swift'

import Cuckoo
import Foundation
@testable import Tennants

class MockAPIManager: APIManager, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = any APIManager
    typealias Stubbing = __StubbingProxy_APIManager
    typealias Verification = __VerificationProxy_APIManager

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any APIManager)?

    func enableDefaultImplementation(_ stub: any APIManager) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    func fetchApiData(selectedBankType p0: String, userId p1: String, storagePath p2: String) async throws -> [TenantPaymentData] {
        return try await cuckoo_manager.callThrows(
            "fetchApiData(selectedBankType p0: String, userId p1: String, storagePath p2: String) async throws -> [TenantPaymentData]",
            parameters: (p0, p1, p2),
            escapingParameters: (p0, p1, p2),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.fetchApiData(selectedBankType: p0, userId: p1, storagePath: p2)
        )
    }

    struct __StubbingProxy_APIManager: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func fetchApiData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(selectedBankType p0: M1, userId p1: M2, storagePath p2: M3) -> Cuckoo.ProtocolStubThrowingFunction<(String, String, String), [TenantPaymentData],Swift.Error> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockAPIManager.self,
                method: "fetchApiData(selectedBankType p0: String, userId p1: String, storagePath p2: String) async throws -> [TenantPaymentData]",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_APIManager: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func fetchApiData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(selectedBankType p0: M1, userId p1: M2, storagePath p2: M3) -> Cuckoo.__DoNotUse<(String, String, String), [TenantPaymentData]> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return cuckoo_manager.verify(
                "fetchApiData(selectedBankType p0: String, userId p1: String, storagePath p2: String) async throws -> [TenantPaymentData]",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class APIManagerStub:APIManager, @unchecked Sendable {


    
    func fetchApiData(selectedBankType p0: String, userId p1: String, storagePath p2: String) async throws -> [TenantPaymentData] {
        return DefaultValueRegistry.defaultValue(for: ([TenantPaymentData]).self)
    }
}




// MARK: - Mocks generated from file: 'History/Data/Supabase/SupabaseNetworkingProtocol.swift'

import Cuckoo
import Foundation
@testable import Tennants

class MockSupabaseNetworkingProtocol: SupabaseNetworkingProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = any SupabaseNetworkingProtocol
    typealias Stubbing = __StubbingProxy_SupabaseNetworkingProtocol
    typealias Verification = __VerificationProxy_SupabaseNetworkingProtocol

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any SupabaseNetworkingProtocol)?

    func enableDefaultImplementation(_ stub: any SupabaseNetworkingProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    func uploadFile(fileData p0: Data, storagePath p1: String, selectedBankType p2: String) async throws {
        return try await cuckoo_manager.callThrows(
            "uploadFile(fileData p0: Data, storagePath p1: String, selectedBankType p2: String) async throws",
            parameters: (p0, p1, p2),
            escapingParameters: (p0, p1, p2),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.uploadFile(fileData: p0, storagePath: p1, selectedBankType: p2)
        )
    }

    func signUp() async throws {
        return try await cuckoo_manager.callThrows(
            "signUp() async throws",
            parameters: (),
            escapingParameters: (),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.signUp()
        )
    }

    func signIn() async throws {
        return try await cuckoo_manager.callThrows(
            "signIn() async throws",
            parameters: (),
            escapingParameters: (),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.signIn()
        )
    }

    func signOut() async throws {
        return try await cuckoo_manager.callThrows(
            "signOut() async throws",
            parameters: (),
            escapingParameters: (),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.signOut()
        )
    }

    func isUserAuthenticated() async {
        return await cuckoo_manager.call(
            "isUserAuthenticated() async",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.isUserAuthenticated()
        )
    }

    func authorise() async throws {
        return try await cuckoo_manager.callThrows(
            "authorise() async throws",
            parameters: (),
            escapingParameters: (),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.authorise()
        )
    }

    struct __StubbingProxy_SupabaseNetworkingProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func uploadFile<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(fileData p0: M1, storagePath p1: M2, selectedBankType p2: M3) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(Data, String, String),Swift.Error> where M1.MatchedType == Data, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Data, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "uploadFile(fileData p0: Data, storagePath p1: String, selectedBankType p2: String) async throws",
                parameterMatchers: matchers
            ))
        }
        
        func signUp() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(),Swift.Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "signUp() async throws",
                parameterMatchers: matchers
            ))
        }
        
        func signIn() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(),Swift.Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "signIn() async throws",
                parameterMatchers: matchers
            ))
        }
        
        func signOut() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(),Swift.Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "signOut() async throws",
                parameterMatchers: matchers
            ))
        }
        
        func isUserAuthenticated() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "isUserAuthenticated() async",
                parameterMatchers: matchers
            ))
        }
        
        func authorise() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(),Swift.Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockSupabaseNetworkingProtocol.self,
                method: "authorise() async throws",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_SupabaseNetworkingProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func uploadFile<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(fileData p0: M1, storagePath p1: M2, selectedBankType p2: M3) -> Cuckoo.__DoNotUse<(Data, String, String), Void> where M1.MatchedType == Data, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(Data, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return cuckoo_manager.verify(
                "uploadFile(fileData p0: Data, storagePath p1: String, selectedBankType p2: String) async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func signUp() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "signUp() async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func signIn() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "signIn() async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func signOut() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "signOut() async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func isUserAuthenticated() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "isUserAuthenticated() async",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func authorise() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "authorise() async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class SupabaseNetworkingProtocolStub:SupabaseNetworkingProtocol, @unchecked Sendable {


    
    func uploadFile(fileData p0: Data, storagePath p1: String, selectedBankType p2: String) async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func signUp() async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func signIn() async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func signOut() async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func isUserAuthenticated() async {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func authorise() async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: 'History/Domain/TennantPayment/TenantPaymentProtocol.swift'

import Cuckoo
import Foundation
@testable import Tennants

class MockTenantPaymentProtocol: TenantPaymentProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = any TenantPaymentProtocol
    typealias Stubbing = __StubbingProxy_TenantPaymentProtocol
    typealias Verification = __VerificationProxy_TenantPaymentProtocol

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any TenantPaymentProtocol)?

    func enableDefaultImplementation(_ stub: any TenantPaymentProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    func getPaymentData(selectedBankType p0: String, userId p1: String) async throws -> [TenantPaymentData] {
        return try await cuckoo_manager.callThrows(
            "getPaymentData(selectedBankType p0: String, userId p1: String) async throws -> [TenantPaymentData]",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getPaymentData(selectedBankType: p0, userId: p1)
        )
    }

    func uploadDocument(url p0: URL, selectedBankType p1: String, userId p2: String) async throws {
        return try await cuckoo_manager.callThrows(
            "uploadDocument(url p0: URL, selectedBankType p1: String, userId p2: String) async throws",
            parameters: (p0, p1, p2),
            escapingParameters: (p0, p1, p2),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.uploadDocument(url: p0, selectedBankType: p1, userId: p2)
        )
    }

    struct __StubbingProxy_TenantPaymentProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func getPaymentData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(selectedBankType p0: M1, userId p1: M2) -> Cuckoo.ProtocolStubThrowingFunction<(String, String), [TenantPaymentData],Swift.Error> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTenantPaymentProtocol.self,
                method: "getPaymentData(selectedBankType p0: String, userId p1: String) async throws -> [TenantPaymentData]",
                parameterMatchers: matchers
            ))
        }
        
        func uploadDocument<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(url p0: M1, selectedBankType p1: M2, userId p2: M3) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(URL, String, String),Swift.Error> where M1.MatchedType == URL, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(URL, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTenantPaymentProtocol.self,
                method: "uploadDocument(url p0: URL, selectedBankType p1: String, userId p2: String) async throws",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_TenantPaymentProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func getPaymentData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(selectedBankType p0: M1, userId p1: M2) -> Cuckoo.__DoNotUse<(String, String), [TenantPaymentData]> where M1.MatchedType == String, M2.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "getPaymentData(selectedBankType p0: String, userId p1: String) async throws -> [TenantPaymentData]",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func uploadDocument<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(url p0: M1, selectedBankType p1: M2, userId p2: M3) -> Cuckoo.__DoNotUse<(URL, String, String), Void> where M1.MatchedType == URL, M2.MatchedType == String, M3.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(URL, String, String)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return cuckoo_manager.verify(
                "uploadDocument(url p0: URL, selectedBankType p1: String, userId p2: String) async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class TenantPaymentProtocolStub:TenantPaymentProtocol, @unchecked Sendable {


    
    func getPaymentData(selectedBankType p0: String, userId p1: String) async throws -> [TenantPaymentData] {
        return DefaultValueRegistry.defaultValue(for: ([TenantPaymentData]).self)
    }
    
    func uploadDocument(url p0: URL, selectedBankType p1: String, userId p2: String) async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: 'Networking/NetworkServiceProtocol.swift'

import Cuckoo
import Foundation
@testable import Tennants

class MockNetworkServiceProtocol: NetworkServiceProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = any NetworkServiceProtocol
    typealias Stubbing = __StubbingProxy_NetworkServiceProtocol
    typealias Verification = __VerificationProxy_NetworkServiceProtocol

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any NetworkServiceProtocol)?

    func enableDefaultImplementation(_ stub: any NetworkServiceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    func fetchData<T: Codable> (from p0: String) async throws -> T {
        return try await cuckoo_manager.callThrows(
            "fetchData<T: Codable> (from p0: String) async throws -> T",
            parameters: (p0),
            escapingParameters: (p0),
            errorType: Swift.Error.self,
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.fetchData(from: p0)
        )
    }

    func createURL(baseURL p0: String, parameters p1: [(String, String)]) -> URL? {
        return cuckoo_manager.call(
            "createURL(baseURL p0: String, parameters p1: [(String, String)]) -> URL?",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.createURL(baseURL: p0, parameters: p1)
        )
    }

    struct __StubbingProxy_NetworkServiceProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func fetchData<M1: Cuckoo.Matchable, T: Codable>(from p0: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), T,Swift.Error> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkServiceProtocol.self,
                method: "fetchData<T: Codable> (from p0: String) async throws -> T",
                parameterMatchers: matchers
            ))
        }
        
        func createURL<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(baseURL p0: M1, parameters p1: M2) -> Cuckoo.ProtocolStubFunction<(String, [(String, String)]), URL?> where M1.MatchedType == String, M2.MatchedType == [(String, String)] {
            let matchers: [Cuckoo.ParameterMatcher<(String, [(String, String)])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkServiceProtocol.self,
                method: "createURL(baseURL p0: String, parameters p1: [(String, String)]) -> URL?",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_NetworkServiceProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func fetchData<M1: Cuckoo.Matchable, T: Codable>(from p0: M1) -> Cuckoo.__DoNotUse<(String), T> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "fetchData<T: Codable> (from p0: String) async throws -> T",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func createURL<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(baseURL p0: M1, parameters p1: M2) -> Cuckoo.__DoNotUse<(String, [(String, String)]), URL?> where M1.MatchedType == String, M2.MatchedType == [(String, String)] {
            let matchers: [Cuckoo.ParameterMatcher<(String, [(String, String)])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "createURL(baseURL p0: String, parameters p1: [(String, String)]) -> URL?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class NetworkServiceProtocolStub:NetworkServiceProtocol, @unchecked Sendable {


    
    func fetchData<T: Codable> (from p0: String) async throws -> T {
        return DefaultValueRegistry.defaultValue(for: (T).self)
    }
    
    func createURL(baseURL p0: String, parameters p1: [(String, String)]) -> URL? {
        return DefaultValueRegistry.defaultValue(for: (URL?).self)
    }
}



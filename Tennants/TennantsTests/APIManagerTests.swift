import Cuckoo
import Foundation
import Testing

@testable import Tennants

@MainActor
@Suite(.serialized)
struct APIManagerTests {
    var apiManager: ApiDataManager
    var mockNetworking: MockNetworkServiceProtocol

    init() {
        mockNetworking = MockNetworkServiceProtocol()
        apiManager = ApiDataManager(networkingManager: mockNetworking)
    }

    @Test
    func setUpApiDataWithValidResults() async {
        let tenantPaymentData = MockData.setUpData()

        stub(mockNetworking) { stub in
            when(stub.createURL(baseURL: any(), parameters: any()))
                .thenReturn(URL(string: "www.example.com")!)
        }

        stub(mockNetworking) { stub in
            when(stub.fetchData(from: "www.example.com"))
                .thenReturn(tenantPaymentData)
        }

        let result = try? await apiManager.fetchApiData(selectedBankType: "", userId: "", storagePath: "")

        #expect(result?.count == 4)
        #expect(result?[0].id == "1")
        #expect(result?[0].date == "2023-01-01")
        #expect(result?[0].reference == "Ref1")
        #expect(result?[0].amount == "100")
        #expect(result?[1].id == "2")
        #expect(result?[1].date == "2023-01-02")
        #expect(result?[1].reference == "Ref2")
        #expect(result?[1].amount == "200")
    }
    
//    func testSetUpApiDataWithEmptyResults() {
//        // Given
//        let tenantPaymentData: [TenantPaymentData] = []
//        
//        // When
//        let result = apiManager.setUpApiData(with: tenantPaymentData)
//        
//        // Then
//        XCTAssertEqual(result.count, 0)
//    }

    @Test
    func setUpApiDataWithNilResults() async {
        // given
        stub(mockNetworking) { stub in
            when(stub.createURL(baseURL: any(), parameters: any()))
                .thenReturn(nil)
        }

        stub(mockNetworking) { stub in
            when(stub.fetchData(from: "www.example.com"))
                .thenReturn(nil as [TenantPaymentData]?)
        }

        let result = try? await apiManager.fetchApiData(selectedBankType: "", userId: "", storagePath: "")

        // Then
        #expect(result == nil)
    }
    
    // MARK: - filterAllPayments
    
}

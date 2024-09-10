import XCTest
import OSLog
@testable import Tennants

class APIManagerTests: XCTestCase {
    var apiManager: ApiDataManager!
    
    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        do {
//            var container = try ModelContainer(for: History.self)
//            apiManager = ApiDataManager(modelContext: container.mainContext)
        } catch {
            
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - setUpApiData
    func testSetUpApiDataWithValidResults() {
        let tenantPaymentData = MockPaymentTenantData().setUpData()
        let result = apiManager.setUpApiData(with: tenantPaymentData)
        
        
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[0].date, "2023-01-01")
        XCTAssertEqual(result[0].reference, "Ref1")
        XCTAssertEqual(result[0].amount, "100")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[1].date, "2023-01-02")
        XCTAssertEqual(result[1].reference, "Ref2")
        XCTAssertEqual(result[1].amount, "200")
    }
    
    func testSetUpApiDataWithEmptyResults() {
        // Given
        let tenantPaymentData: [TenantPaymentData] = []
        
        // When
        let result = apiManager.setUpApiData(with: tenantPaymentData)
        
        // Then
        XCTAssertEqual(result.count, 0)
    }
    
    func testSetUpApiDataWithNilResults() {
        // given
        let result = apiManager.setUpApiData(with: nil)
        
        // Then
        XCTAssertEqual(result.count, 0)
    }
    
    // MARK: - filterAllPayments
    
}

class MockPaymentTenantData {
    func setUpData() -> [TenantPaymentData] {
        var data: [TenantPaymentData] = []
        
        return data
    }
}


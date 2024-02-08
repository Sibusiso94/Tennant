import XCTest
@testable import Tennants

final class UpdateTennatViewModelTests: XCTestCase {
    var sut: UpdateTennantViewModel!

    override func setUpWithError() throws {
        sut = UpdateTennantViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetNumberOfMonthsPassedStartValueIs0Succeeded() {
        XCTAssertEqual(sut.numberOfMonthsPassed, 0) 
    }

    #warning("test for future dates")
    func testGetNumberOfMonthsPassedDidSucceeded() {
        // Given
        let startDate = "2023-04-19"
        let endDate = "2023-11-19"
        
        // When
        sut.getNumberOfMonthsPassed(startDate: startDate, endDate: endDate.getStringAsDate())
        
        // Then
        XCTAssertEqual(sut.numberOfMonthsPassed, 7)
    }
    
    func testGetNumberOfMonthsPassedDidFail() {
        // Given
        let startDate = "2023-04-19"
        let endDate = "2023-11-19"
        
        // When
        sut.getNumberOfMonthsPassed(startDate: startDate, endDate: endDate.getStringAsDate())
        
        // Then
        XCTAssertNotEqual(sut.numberOfMonthsPassed, 2)
    }
    
    func testGetPaymentHistoryPercentageDidSucceed() {
        let numberOfMonthsPassed = 10
        let numberOfFullPayments = 6
        
        let result = sut.getPaymentHistoryPercentage(numberOfMonthsPassed: numberOfMonthsPassed, numberOfFullPayments: numberOfFullPayments)
        
        XCTAssertEqual(result, 0.6)
    }
    
    func testGetPaymentHistoryPercentageDidFail() {
        let numberOfMonthsPassed = 6
        let numberOfFullPayments = 10
        
        let result = sut.getPaymentHistoryPercentage(numberOfMonthsPassed: numberOfMonthsPassed, numberOfFullPayments: numberOfFullPayments)
        
        XCTAssertNotEqual(result, 0.6)
    }
    
    func testGetPercentageDidSucceeded() {
        let input = 0.8
        let expectedResult = "80%"
        
        let result = sut.getPercentage(percentageDouble: input)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testGetPercentageDidFail() {
        let input = 0.4
        let expectedResult = "80%"
        
        let result = sut.getPercentage(percentageDouble: input)
        
        XCTAssertNotEqual(result, expectedResult)
    }
}

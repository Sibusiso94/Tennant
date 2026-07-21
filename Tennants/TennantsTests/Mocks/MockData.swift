import Foundation

@testable import Tennants
struct MockData {
    static let mockResponse = Data("""
        [
          { "id": "1", "date": "2023-01-01", "reference": "Ref1", "amount": "100" },
          { "id": "2", "date": "2023-01-02", "reference": "Ref2", "amount": "200" },
          { "id": "3", "date": "2023-01-03", "reference": "Ref3", "amount": "300" },
          { "id": "4", "date": "2023-01-04", "reference": "Ref4", "amount": "400" }
        ]
        """.utf8)


    
    static func setUpData() -> [TenantPaymentData] {
        return [
            TenantPaymentData(
                id: "1",
                date: "2023-01-01",
                reference: "Ref1",
                amount: "100"
            ),
            TenantPaymentData(
                id: "2",
                date: "2023-01-02",
                reference: "Ref2",
                amount: "200"
            ),
            TenantPaymentData(
                id: "3",
                date: "2023-01-03",
                reference: "Ref3",
                amount: "300"
            ),
            TenantPaymentData(
                id: "4",
                date: "2023-01-04",
                reference: "Ref4",
                amount: "400"
            )
        ]
    }
}

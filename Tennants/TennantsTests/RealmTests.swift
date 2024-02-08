import XCTest
import RealmSwift
@testable import Tennants

final class RealmTests: XCTestCase {
    var defaultRealmPath: URL!
    var realm: Realm!
    var sut: RealmRepository!
    
    override func setUpWithError() throws {
        let path = Bundle.main.path(forResource: "count", ofType: "realm") ?? ""
        let realmURL = URL(fileURLWithPath: path)
        
        _ = try! FileManager.default.replaceItemAt(Realm.Configuration.defaultConfiguration.fileURL!, withItemAt: realmURL)
        defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        
        let config = Realm.Configuration(fileURL: defaultRealmPath)
        realm = try! Realm(configuration: config)
        sut = RealmRepository()
    }

    override func tearDownWithError() throws {
        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            realm = nil
        sut = nil
    }

//    func testExample() throws {
//        sut.add(Tennant(buildingNumber: "13130",
//                        flatNumber: "3", name: "Wolbesto", surname: "Polesto", company: "Beresto", position: "Manager", monthlyIncome: 7000, balance: -290, amountDue: 290, startDate: "2024-09-12", endDate: "2025-10-13", fullPayments: 2), to: realm)
//        
//        XCTAssertEqual(realm.objects(Tennant.self).first!.name, "Wolbesto")
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

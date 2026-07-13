import Foundation

class TenantPaymentDataProvider: MultipleObjectsCreatable {
    typealias T = TenantData

    let repository: SwiftDataRepository

    init(repository: SwiftDataRepository) {
        self.repository = repository
    }

    func createMultiple(_ object: [T]) {
        do {
            try repository.createMultiple(object)
        } catch let error {

        }
    }

    func fetchData() -> [T] {
        let data = repository.readAll(T.self)
        return data
    }
}

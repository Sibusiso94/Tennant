import Foundation

class TenantPaymentDataProvider: MultipleObjectsCreatable {
    typealias T = TenantData

    let repository: RealmRepository

    init(repository: RealmRepository) {
        self.repository = repository
    }

    func createMultiple(_ object: [T]) {
        do {
            try repository.createMultiple(object)
        } catch let error {

        }
    }

    func fetchData() -> [T] {
//        let descriptor = FetchDescriptor<T>(sortBy: [SortDescriptor(\.unitNumber, order: .forward)])
        let data = repository.readAll(T.self)
        return data
    }
}

import Testing

@testable import Tennants

@Suite(.serialized)
struct HistoryManagerTests {
    let sut: HistoryManagable

    init() {
        let mockRepo = MockDataSource()
        sut = HistoryManager(repository: mockRepo)
    }


}

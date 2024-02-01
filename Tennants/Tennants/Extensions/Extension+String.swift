import Foundation

extension String {
    func getStringAsDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: self) else { return Date.now }
        return startDate
    }
}

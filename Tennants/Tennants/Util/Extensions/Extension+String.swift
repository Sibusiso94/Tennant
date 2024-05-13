import Foundation

extension String {
    func getStringAsDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: self) else { return Date.now }
        return startDate
    }
}

extension Date {
    func getDateAsString() -> String {
        return self.formatted(date: .numeric, time: .omitted)
    }
}

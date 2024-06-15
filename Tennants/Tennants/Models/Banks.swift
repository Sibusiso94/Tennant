import Foundation
import SwiftUI

struct Bank: Hashable {
    var title: String
    var image: String
    
    static func == (lhs: Bank, rhs: Bank) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

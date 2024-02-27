import Foundation
import SwiftUI

struct ValidationPreferenceKey: PreferenceKey {
    static var defaultValue: [Bool] = []
    
    static func reduce(value: inout [Bool], nextValue: () -> [Bool]) {
        value += nextValue()
    }
}

import Foundation

struct Entry: Identifiable {
    let id = UUID()
    let description: String
    let points: Int
    let category: String
}

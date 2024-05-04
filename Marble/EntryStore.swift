import Foundation

class EntryStore: ObservableObject {
    @Published var entries: [Entry] = []
    
    func addEntry(description: String, points: Int, category: String) {
        let entry = Entry(description: description, points: points, category: category)
        entries.append(entry)
    }
}

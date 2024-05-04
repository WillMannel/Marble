import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var entryStore: EntryStore
    
    var body: some View {
        List(entryStore.entries) { entry in
            VStack(alignment: .leading) {
                Text(entry.description)
                Text("Points: \(entry.points)")
                Text("Category: \(entry.category)")
            }
        }
    }
}

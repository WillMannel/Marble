import SwiftUI

struct EntryFormView: View {
    @EnvironmentObject var entryStore: EntryStore
    
    @State private var description = ""
    @State private var points = 0
    @State private var selectedCategory = "Knowledge"
    
    var body: some View {
        Form {
            Section(header: Text("Add New Entry")) {
                TextField("Description", text: $description)
                Stepper("Points: \(points)", value: $points)
                Picker("Category", selection: $selectedCategory) {
                    Text("Knowledge").tag("Knowledge")
                    Text("Skills").tag("Skills")
                    Text("Health").tag("Health")
                    Text("Wellness").tag("Wellness")
                    Text("Belonging").tag("Belonging")
                    Text("Experience").tag("Experience")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button("Add Entry") {
                entryStore.addEntry(description: description, points: points, category: selectedCategory)
                description = ""
                points = 0
                selectedCategory = "Knowledge"
            }
            .foregroundColor(.blue)
        }
    }
}

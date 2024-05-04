import SwiftUI
struct ContentView: View {
    @StateObject var entryStore = EntryStore()
    
    var body: some View {
        NavigationView {
            VStack {
                EntryFormView()
                    .environmentObject(entryStore)
                
                EntryListView()
                    .environmentObject(entryStore)
                
                NavigationLink(destination: SpiderChartView().environmentObject(entryStore)) {
                    Text("View Spider Chart")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Self Improvement Tracker")
        }
    }
}

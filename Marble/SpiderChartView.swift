import SwiftUI

struct SpiderChartView: View {
    let categories = ["Knowledge", "Skills", "Health", "Wellness", "Belonging", "Experience"]
    
    @EnvironmentObject var entryStore: EntryStore
    
    @State private var manualPoints: [String: Int] = [:]
    
    var body: some View {
        VStack {
            Text("Spider Chart")
                .font(.title)
                .padding()
            
            if !entryStore.entries.isEmpty {
                SpiderChart(categories: categories, entries: entryStore.entries, manualPoints: $manualPoints)
                    .frame(width: 300, height: 300)
            } else {
                Text("No data available.")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    TextField("\(category) Points", text: Binding(
                        get: { manualPoints[category] != nil ? String(manualPoints[category]!) : "" },
                        set: { manualPoints[category] = Int($0) ?? 0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 120)
                    .padding()
                }
            }
        }
    }
}

struct SpiderChart: View {
    let categories: [String]
    let entries: [Entry]
    @Binding var manualPoints: [String: Int]
    
    var body: some View {
        let maxPoints = 10.0 // Set the maximum points for scaling
        
        let dataPoints: [Double] = categories.map { category in
            let categoryEntries = entries.filter { $0.category == category }
            let totalPoints = categoryEntries.reduce(0) { $0 + Double($1.points) }
            let manualPointsValue = manualPoints[category] ?? 0
            return (totalPoints + Double(manualPointsValue)) / Double(categoryEntries.count + (manualPointsValue > 0 ? 1 : 0))
        }
        
        let numberOfDataPoints = Double(dataPoints.count)
        let angle = 2 * .pi / numberOfDataPoints
        
        return ZStack {
            ForEach(0..<dataPoints.count) { index in
                let factor = CGFloat(dataPoints[index] / maxPoints)
                let x = factor * cos(CGFloat(index) * angle)
                let y = factor * sin(CGFloat(index) * angle)
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                .stroke(lineColor(forIndex: index), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .fill(circleColor(forIndex: index))
                    .frame(width: 8, height: 8)
                    .offset(x: x, y: y)
                
                Text("\(dataPoints[index], specifier: "%.1f")")
                    .position(x: x + 20 * cos(CGFloat(index) * angle), y: y + 20 * sin(CGFloat(index) * angle))
                Text(categories[index])
                    .font(.caption)
                    .position(x: x + 40 * cos(CGFloat(index) * angle), y: y + 40 * sin(CGFloat(index) * angle) + 20)  // Added +20 to y position



            }
            
            Path { path in
                for index in 0..<dataPoints.count {
                    let factor = CGFloat(dataPoints[index] / maxPoints)
                    let x = factor * cos(CGFloat(index) * angle)
                    let y = factor * sin(CGFloat(index) * angle)
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                path.closeSubpath()
            }
            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(20)
    }
    
    func lineColor(forIndex index: Int) -> Color {
        switch index {
        case 0:
            return .red
        case 1:
            return .blue
        case 2:
            return .green
        case 3:
            return .yellow
        case 4:
            return .purple
        case 5:
            return .orange
        default:
            return .black
        }
    }
    
    func circleColor(forIndex index: Int) -> Color {
        switch index {
        case 0:
            return .red
        case 1:
            return .blue
        case 2:
            return .green
        case 3:
            return .yellow
        case 4:
            return .purple
        case 5:
            return .orange
        default:
            return .black
        }
    }
}

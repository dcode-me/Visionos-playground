//
//  BarChartView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

// Import SwiftUI and Charts frameworks
import SwiftUI
import Charts

// Define a structure for the data to be displayed in the chart
struct ChartData: Identifiable {
  
  let id = UUID()
  var category: String
  var value: Double
  var barColor: colorcode
  
}

// Define a SwiftUI view for the bar chart
struct BarChartView: View {
  // Sample data for the bar chart
  let data: [ChartData] = [
    ChartData(category: "JAN", value: 1000, barColor: .Red),
    ChartData(category: "FEB", value: 1500, barColor: .Red),
    ChartData(category: "MAR", value: 800, barColor: .Red),
    ChartData(category: "APR", value: 1200, barColor: .Red),
    ChartData(category: "MAY", value: 1200, barColor: .Red),
    ChartData(category: "JUN", value: 1200, barColor: .blue),
    ChartData(category: "JUN", value: 1200, barColor: .gray)
  ]
  
  private var barGradient: LinearGradient {
    LinearGradient(
      gradient: Gradient(stops: [
        .init(color: Color.white.opacity(0.1), location: 0.0),
        .init(color: Color.white.opacity(0.1), location: 0.41),
        .init(color: Color.white.opacity(0.1), location: 0.57),
        .init(color: Color.white.opacity(0.1), location: 1.0)
      ]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  private var positiveGradient: LinearGradient{
    LinearGradient(
      gradient: Gradient(colors: [Color.green, Color.green]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  private var negativeGradient: LinearGradient{
    LinearGradient(
      gradient: Gradient(colors: [Color.red, Color.red]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  private var whiteGradient: LinearGradient{
    LinearGradient(
      gradient: Gradient(colors: [Color.white, Color.white]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  var revenueGradient: LinearGradient {
    LinearGradient(gradient: Gradient(colors: [.yellow, .purple]), startPoint: .trailing, endPoint: .leading)
  }
  
  var body: some View {
    // Use the Chart view to create a bar chart
    Chart(data) { datum in
      
      BarMark(
        x: .value("Category", datum.category),
        y: .value("Value", datum.value), width: .fixed(32)
      ).cornerRadius(6)
        .foregroundStyle(by: .value("barColor", datum.barColor.rawValue))
        .annotation(position: .overlay, alignment: .bottom){
          if datum.barColor.rawValue == "BLUE" {
            Text(datum.category).font(.system(size: 10, weight: .light)).foregroundColor(.black)
          }
          else if datum.barColor.rawValue != "BLACK"{
            Text(datum.category).font(.system(size: 10, weight: .light))
          }
          
        }
    }
    .chartForegroundStyleScale([colorcode.Red:barGradient,colorcode.blue:whiteGradient,colorcode.gray:positiveGradient])
    .chartLegend(.hidden)
    .frame(width: 202, height: 56 ) // Set the height of the chart
    .chartYAxis(.hidden)
    .chartXAxis(.hidden)
  }
}

#Preview {
  BarChartView()
}

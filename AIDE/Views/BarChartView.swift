//
//  BarChartView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

// Import SwiftUI and Charts frameworks
import SwiftUI
import Charts

struct BarChartView: View {
  
    var barData: [GraphValues]
  
//  var resultGraph:[GraphValues] = [
//    
//    GraphValues(monthIndex: 6, month: Month.jan, formattedNumber: 20.0, type: .dataValue),
//    GraphValues(monthIndex: 5, month: Month.feb, formattedNumber: 30.0, type: .dataValue),
//    GraphValues(monthIndex: 4, month: Month.mar, formattedNumber: 30.0, type: .dataValue),
//    GraphValues(monthIndex: 3, month: Month.apr, formattedNumber: 30.0, type: .dataValue),
//    GraphValues(monthIndex: 2, month: Month.may, formattedNumber: 30.0, type: .dataValue),
//    GraphValues(monthIndex: 1, month: Month.jun, formattedNumber: 30.0, type: .currentMonth),
//    GraphValues(monthIndex: 0, month: Month.jun, formattedNumber: 5.0, type: .deltaNegative)
//  ]
  
  
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
  
  var body: some View {
//    let data1 = resultGraph.sorted { $0.monthIndex > $1.monthIndex }
    Chart(barData) { datum in
      BarMark(
        x: .value("Month", datum.month.rawValue),
        y: .value("Value", datum.formattedNumber), width: .fixed(32)
      ).cornerRadius(6)
        .foregroundStyle(by: .value("type", datum.type.rawValue))
        .annotation(position: .overlay, alignment: .bottom){
          if datum.type.rawValue == "Current" {
            Text(datum.month.rawValue).font(.system(size: 10, weight: .light)).foregroundColor(.black)
          }
          else if datum.type.rawValue == "DataValue"{
            Text(datum.month.rawValue).font(.system(size: 10, weight: .light))
          }
          
        }
    }
    .chartForegroundStyleScale([DataCategory.dataValue.rawValue:barGradient,DataCategory.deltaPositive.rawValue: positiveGradient,DataCategory.deltaNegative.rawValue: negativeGradient,DataCategory.currentMonth.rawValue:whiteGradient])
    .chartLegend(.hidden)
    .frame(width: 202, height: 56 ) // Set the height of the chart
    .chartYAxis(.hidden)
    .chartXAxis(.hidden)
  }
}

#Preview {
    BarChartView(barData: [])
//  BarChartView()
}

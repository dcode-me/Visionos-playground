//
//  KPIView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

import SwiftUI

struct KPIView: View {
  @StateObject private var viewModel: KPIViewModel
  
  init() {
    let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM-yyyy"
    let defaultMonthYear = dateFormatter.string(from: previousMonthDate)
    _viewModel = StateObject(wrappedValue: KPIViewModel(monthYear: defaultMonthYear))
  }
  
  var body: some View {
    VStack {
//      MonthYearPickerView(monthYear: $viewModel.selectedMonthYear)
      
      List {
        ForEach(Array(viewModel.allKPIData.keys), id: \.self) { kpiName in
          if let kpiGraphData = viewModel.allKPIData[kpiName] {
            Text(kpiName.rawValue)
            Text(kpiGraphData.currentMonthData.valueLabel)
          }
        }
      }
    }
    .navigationTitle("KPI Dashboard")
  }
}

#Preview {
  KPIView()
}

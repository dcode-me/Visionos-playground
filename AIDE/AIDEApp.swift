//
//  AIDEApp.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-01.
//

import SwiftUI

@main
struct AIDEApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
//      BarChartView()
      DashboardView()
//      CalendarSheet(selectedMonth: .jun, selectedYear: .year2024)
        .frame(
          minWidth: 1600, maxWidth: 2560,
          minHeight: 900, maxHeight: 1440)
    }
    .defaultSize(CGSize(width: 1600, height: 900))
    .windowResizability(.contentSize)
  }
}

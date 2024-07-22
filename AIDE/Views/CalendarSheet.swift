//
//  CalendarSheet.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct CalendarSheet: View {
  @State var showSheet = false
  @State var selectedMonth: Month
  @State var selectedYear: Year
    var body: some View {
      NavigationView {
        CalendarView()
          .navigationTitle("Select Month")
          .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
              Button(action: {
                print("Button with SF Symbol tapped")
              }) {
                Label("Close", systemImage: "xmark")
              }
            }
          }
      }.navigationViewStyle(StackNavigationViewStyle()).frame(width:480, height: 600)
    }
}

#Preview {
  CalendarSheet(selectedMonth: .jun, selectedYear: .year2024)
}

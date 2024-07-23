//
//  TestView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-23.
//

import SwiftUI

struct TestView: View {
  @State private var showingCalendar = false
      
      var body: some View {
          Button("Show Calendar") {
              showingCalendar = true
          }
          .sheet(isPresented: $showingCalendar) {
//            CalendarView()
          }
      }
}

#Preview {
    TestView()
}

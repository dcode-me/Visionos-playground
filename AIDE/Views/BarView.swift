//
//  BarView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-22.
//

import SwiftUI
import Charts

struct BarView: View {
//  var barData: [GraphValues]
  var data:[GraphValues] = [
    GraphValues(monthIndex: 0, month: Month.jun, formattedNumber: 10.0, type: .dataValue),
    GraphValues(monthIndex: 1, month: Month.may, formattedNumber: 20.0, type: .dataValue),
    GraphValues(monthIndex: 2, month: Month.apr, formattedNumber: 30.0, type: .dataValue)
  ]
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      Chart(data){ datum in
        BarMark(
          x: .value("Month", datum.month.rawValue), y: .value("Value", datum.formattedNumber)
        )
      }
    }
}

#Preview {
  VStack{
    BarView()
  }
}

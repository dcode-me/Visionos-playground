//
//  CalendarView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct CalendarView: View {
  var body: some View {
    VStack(spacing: 24)  {
      // Years
      HStack(spacing: 24) {
        ForEach(Year.allCases, id: \.self) { year in
          Button(action: {
            print("Year \(year.rawValue) selected")
          }) {
            Label("\(year.rawValue)", systemImage: "square.and.arrow.up").labelStyle(.titleOnly).frame(width: 89, height: 52)
          }
          .buttonBorderShape(.roundedRectangle(radius: 16))
        }
      }
      .padding(.bottom, 24)
      .overlay(Rectangle().frame(height: 1).foregroundColor(.white), alignment: .bottom)
      
      // Months
      let months = Array(Month.allCases)
      ForEach(0..<4) { rowIndex in
        HStack(spacing: 24) {
          ForEach(0..<3) { columnIndex in
            let month = months[rowIndex * 3 + columnIndex]
            Button(action: {
              print("Month \(month.rawValue) selected")
            }) {
              Label(month.rawValue, systemImage: "square.and.arrow.up").labelStyle(.titleOnly).frame(width:89, height: 52)
            }
           .buttonBorderShape(.roundedRectangle(radius: 16))
          }
        }
      }
    }
  }
}

#Preview {
  CalendarView()
}

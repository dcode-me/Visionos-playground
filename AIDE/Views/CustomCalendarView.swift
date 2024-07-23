//
//  CustomCalendarView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-23.
//

import SwiftUI

struct CustomCalendarView: View {
  @ObservedObject var viewModel = CalendarViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      // Close Button
      Button(action: {
        presentationMode.wrappedValue.dismiss() // Dismiss the view
      }) {
        Image(systemName: "xmark") // You can customize this button as needed
          .padding()
          .accessibilityLabel("Close")
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      
      // Year Selection
      Picker("Year", selection: $viewModel.selectedYear) {
        ForEach(viewModel.calendarYear, id: \.self) { year in
          Text("\(year)").tag(year)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      
      // Month Selection
      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
        ForEach(viewModel.calendarMonths, id: \.self) { month in
          Text(month)
            .padding()
            .background(viewModel.selectedMonth == month ? Color.blue : Color.clear)
            .cornerRadius(5)
            .onTapGesture {
              viewModel.selectedMonth = month
            }
        }
      }
      
      // Confirm Button
      Button("Confirm") {
        // Action to return selected month and year
        print("Selected Month and Year: \(viewModel.selectedMonth) \(viewModel.selectedYear)")
        presentationMode.wrappedValue.dismiss() // Optionally dismiss after confirming
      }
      .padding()
    }
    .padding()
  }
}

#Preview {
  CustomCalendarView()
}

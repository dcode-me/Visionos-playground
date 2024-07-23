//
//  CalendarView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct CalendarView: View {
  @ObservedObject var viewModel = CalendarViewModel()
  @Binding var selectedYear: Int
  @Binding var selectedMonth: String
  @Environment(\.presentationMode) var presentationMode
  var onConfirm: ((Int, String) -> Void)?
  
  var body: some View {
    NavigationView {
      VStack(spacing: 24)  {
        // Years
        HStack(spacing: 24) {
          ForEach(viewModel.calendarYear, id: \.self) { calYear in
            Text("\(String(calYear))")
              .font(.largeTitle)
              .padding()
              .background(viewModel.selectedYear == calYear ? Color.blue : Color.clear)
            //            .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16.0), displayMode: .implicit)
              .foregroundColor(.white)
              .onTapGesture {
                viewModel.selectedYear = calYear
              }
          }
        }
        .padding(.bottom, 24)
        .overlay(Rectangle().frame(height: 1).foregroundColor(.white), alignment: .bottom)
        
        // Months
        let months = Array(viewModel.calendarMonths)
        ForEach(0..<4) { rowIndex in
          HStack(spacing: 24) {
            ForEach(0..<3) { columnIndex in
              let month = months[rowIndex * 3 + columnIndex]
              Text("\(month)")
                .font(.largeTitle)
                .padding()
                .background(viewModel.selectedMonth == month ? Color.blue : Color.clear)
              //              .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16.0), displayMode: .implicit)
                .foregroundColor(.white)
                .onTapGesture {
                  viewModel.selectedMonth = month
                }
            }
          }
        }
        
        Button("Confirm") {
          onConfirm?(viewModel.selectedYear, viewModel.selectedMonth)
          print("Selected Month and Year: \(viewModel.selectedMonth) \(viewModel.selectedYear)")
//          selectedYear = viewModel.selectedYear
//          selectedMonth = viewModel.selectedMonth
          presentationMode.wrappedValue.dismiss()
        }
        .padding(24)
      }
        .navigationTitle("Select Month")
        .toolbar {
          ToolbarItemGroup(placement: .topBarLeading) {
            Button(action: {
              presentationMode.wrappedValue.dismiss()
              print("Button with SF Symbol tapped")
            }) {
              Label("Close", systemImage: "xmark")
            }
          }
        }
    }.navigationViewStyle(StackNavigationViewStyle())
    
  }
}

#Preview {
  CalendarView(selectedYear: Binding.constant(2024), selectedMonth: Binding.constant("JUN"))
}

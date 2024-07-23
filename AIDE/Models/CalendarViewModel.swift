//
//  CalendarViewModel.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-23.
//

import Foundation

class CalendarViewModel: ObservableObject {
    let calendarYear = [2021, 2022, 2023, 2024]
    let calendarMonths = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
    @Published var selectedYear: Int
    @Published var selectedMonth: String
    
    init() {
        // Initial selected month and year
        self.selectedYear = 2024
        self.selectedMonth = "Jun"
    }
}

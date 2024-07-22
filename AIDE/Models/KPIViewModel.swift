//
//  KPIViewModel.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-18.
//

import Foundation
import Combine

class KPIViewModel: ObservableObject {
    @Published var allKPIData: [KPIName: KPIGraphData] = [:]
    @Published var selectedMonthYear: String {
        didSet {
            loadData()
        }
    }

    init(monthYear: String) {
        self.selectedMonthYear = monthYear
        DashboardData.loadData() // Assuming this populates KPIData.allData
        loadData()
    }

    func loadData() {
        guard !selectedMonthYear.isEmpty else { return }
        allKPIData = DashboardData.retrieveDataForAllKPIs(monthYear: selectedMonthYear)
    }
}

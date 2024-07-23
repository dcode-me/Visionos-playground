//
//  KPIGraphData.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-18.
//

import Foundation

struct KPIGraphData {
  let currentMonthData: KPIData
  let pastSixMonthsData: [GraphValues]
}

struct GraphValues: Identifiable{
  var id =  UUID()
  
  let monthIndex: Int
  let month: Month
  let formattedNumber: Double
  let type: DataCategory
}

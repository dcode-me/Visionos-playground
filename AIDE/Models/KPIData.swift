//
//  KPIData.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-15.
//

import Foundation

class KPIData {
  var month: Month
  var year: Year
  var rawValue: Double
  var formattedNumber: Double
  var valueLabel: String
  var unit: Unit
  var isIncreasing: Bool
  var isPositiveSentiment: Bool
  
  //  "JAN-2021": KPIData(month: .JAN, year: .year2021, rawValue: 5000.0, formattedNumber: 5.0, valueLabel: "5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
  init(month: Month, year: Year, rawValue: Double, formattedNumber: Double, valueLabel: String, unit: Unit, isIncreasing: Bool, isPositiveSentiment: Bool) {
    self.month = month
    self.year = year
    self.rawValue = rawValue
    self.formattedNumber = formattedNumber
    self.valueLabel = valueLabel
    self.unit = unit
    self.isIncreasing = isIncreasing
    self.isPositiveSentiment = isPositiveSentiment
  }
}

//
//  DashboardData.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

import Foundation

struct DashboardData {
  
  static var allData : [KPIName: [String: KPIData]] = [:]
  
  static func retrieveDataForAllKPIs(monthYear: String) -> [KPIName: KPIGraphData] {
    print(monthYear)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM-yyyy"
    guard let specifiedDate = dateFormatter.date(from: monthYear) else { return [:] }
    print("DAte is : \(specifiedDate) ")
    
    var result: [KPIName: KPIGraphData] = [:]
    
    // Mapping from month numbers to KPIData.Month strings
    let monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    for (kpiName, monthlyData) in allData {
      print("Loading: \(kpiName) with number of records \(monthlyData.count)")
      var pastSixMonthsData: [GraphValues] = []
      
      for i in 0...5 {
        
        guard let targetDate = Calendar.current.date(byAdding: .month, value: -i, to: specifiedDate),
              let monthInt = Calendar.current.dateComponents([.month], from: targetDate).month,
              let year = Calendar.current.dateComponents([.year], from: targetDate).year,
              monthInt > 0 && monthInt <= monthNames.count else { continue }
        
        //              let monthEnumValue = monthNames[monthInt - 1]
        let monthYearKey = dateFormatter.string(from: targetDate).uppercased()
        //        print("target \(monthYearKey)")
        if let kpiData = monthlyData[monthYearKey] {
          //          print("KPIDATA \(kpiData)")
          var dataType: DataCategory = .dataValue
          if i==0 {
            dataType = .currentMonth
          }
          let graphValue = GraphValues(monthIndex: i+1, month: kpiData.month, formattedNumber: kpiData.formattedNumber, type: dataType)
          
          pastSixMonthsData.append(graphValue)
        }
      }
      
      // Ensure the list is ordered from the oldest to the most recent month
      let orderedPastSixMonthsData = pastSixMonthsData.sorted(by: { $0.monthIndex < $1.monthIndex })
      //      print(orderedPastSixMonthsData)
      //      print("Done with \(kpiName)")
      
      // Assuming the current month's data is also available in `monthlyData`
      let currentMonthKey = dateFormatter.string(from: specifiedDate).uppercased()
      if let currentMonthData = monthlyData[currentMonthKey] {
        //        print("Current MOnth \(currentMonthData)")
        let kpiGraphData = KPIGraphData(currentMonthData: currentMonthData, pastSixMonthsData: orderedPastSixMonthsData)
        result[kpiName] = kpiGraphData
        //        print(result)
      }
    }
    return result
  }
  
  static func loadData() {
    allData[.revenueCAD] = loadRevenueCADData()[.revenueCAD] ?? [:]
    allData[.revenueUSD] = loadRevenueUSDData()[.revenueUSD] ?? [:]
    allData[.sucessfulLogins] = loadSuccessfulLogin()[.sucessfulLogins] ?? [:]
    allData[.avgRevenueCAD] = loadAvgRevenueCADData()[.avgRevenueCAD] ?? [:]
    allData[.avgRevenueUSD] = loadAvgRevenueUSDData()[.avgRevenueUSD] ?? [:]
    allData[.uniqueUsers] = loadUniqueUsersData()[.uniqueUsers] ?? [:]
    allData[.helpdeskCalls] = loadHDcallsData()[.helpdeskCalls] ?? [:]
    allData[.servicenowTickets] = loadSNTicketsData()[.servicenowTickets] ?? [:]
    allData[.helpcenter] = loadHelpCenterData()[.helpcenter] ?? [:]
  }
  
  static func loadRevenueCADData() -> [KPIName: [String: KPIData]] {
    return [
      .revenueCAD: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 5000.0, formattedNumber: 5.0, valueLabel: "5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 5500.0, formattedNumber: 5.5, valueLabel: "5.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 6000.0, formattedNumber: 6.0, valueLabel: "6K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 6500.0, formattedNumber: 6.5, valueLabel: "6.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 7000.0, formattedNumber: 7.0, valueLabel: "7K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 7500.0, formattedNumber: 7.5, valueLabel: "7.5K", unit: .thousands, isIncreasing: false, isPositiveSentiment: false)
      ]
    ]
  }
  
  static func loadRevenueUSDData() -> [KPIName: [String: KPIData]] {
    return [
      .revenueUSD: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 5000.0, formattedNumber: 5.0, valueLabel: "5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 5500.0, formattedNumber: 5.5, valueLabel: "5.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 6000.0, formattedNumber: 6.0, valueLabel: "6K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 6500.0, formattedNumber: 6.5, valueLabel: "6.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 7000.0, formattedNumber: 7.0, valueLabel: "7K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 7500.0, formattedNumber: 7.5, valueLabel: "7.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadSuccessfulLogin() -> [KPIName: [String: KPIData]] {
    return [
      .sucessfulLogins: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 10000.0, formattedNumber: 10.0, valueLabel: "10K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 12000.0, formattedNumber: 12.0, valueLabel: "12K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 13000.0, formattedNumber: 13.0, valueLabel: "13K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 14000.0, formattedNumber: 14.0, valueLabel: "14K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 15000.0, formattedNumber: 15.0, valueLabel: "15K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 16000.0, formattedNumber: 16.0, valueLabel: "16K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadAvgRevenueCADData() -> [KPIName: [String: KPIData]] {
    return [
      .avgRevenueCAD: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 5000.0, formattedNumber: 5.0, valueLabel: "5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 5500.0, formattedNumber: 5.5, valueLabel: "5.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 6000.0, formattedNumber: 6.0, valueLabel: "6K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 6500.0, formattedNumber: 6.5, valueLabel: "6.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 7000.0, formattedNumber: 7.0, valueLabel: "7K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 7500.0, formattedNumber: 7.5, valueLabel: "7.5K", unit: .hundreds, isIncreasing: true, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadAvgRevenueUSDData() -> [KPIName: [String: KPIData]] {
    return [
      .avgRevenueUSD: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 5000.0, formattedNumber: 5.0, valueLabel: "5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 5500.0, formattedNumber: 5.5, valueLabel: "5.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 6000.0, formattedNumber: 6.0, valueLabel: "6K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 6500.0, formattedNumber: 6.5, valueLabel: "6.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 7000.0, formattedNumber: 7.0, valueLabel: "7K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 7500.0, formattedNumber: 7.5, valueLabel: "7.5K", unit: .hundreds, isIncreasing: true, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadUniqueUsersData() -> [KPIName: [String: KPIData]] {
    return [
      .uniqueUsers: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 10000.0, formattedNumber: 10.0, valueLabel: "10K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 12000.0, formattedNumber: 12.0, valueLabel: "12K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 13000.0, formattedNumber: 13.0, valueLabel: "13K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 14000.0, formattedNumber: 14.0, valueLabel: "14K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 15000.0, formattedNumber: 15.0, valueLabel: "15K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 16000.0, formattedNumber: 16.0, valueLabel: "16K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadHDcallsData() -> [KPIName: [String: KPIData]] {
    return [
      .helpdeskCalls: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 150.0, formattedNumber: 150.0, valueLabel: "150", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 180.0, formattedNumber: 180.0, valueLabel: "180", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 160.0, formattedNumber: 160.0, valueLabel: "160", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 140.0, formattedNumber: 140.0, valueLabel: "140", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 130.0, formattedNumber: 130.0, valueLabel: "130", unit: .thousands, isIncreasing: false, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadSNTicketsData() -> [KPIName: [String: KPIData]] {
    return [
      .servicenowTickets: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 150.0, formattedNumber: 150.0, valueLabel: "150", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 180.0, formattedNumber: 180.0, valueLabel: "180", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 160.0, formattedNumber: 160.0, valueLabel: "160", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 140.0, formattedNumber: 140.0, valueLabel: "140", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 130.0, formattedNumber: 130.0, valueLabel: "130", unit: .thousands, isIncreasing: false, isPositiveSentiment: true)
      ]
    ]
  }
  
  static func loadHelpCenterData() -> [KPIName: [String: KPIData]] {
    return [
      .helpcenter: [
        "DEC-2023": KPIData(month: .dec, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "JAN-2024": KPIData(month: .jan, year: .year2021, rawValue: 200.0, formattedNumber: 200.0, valueLabel: "200", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "FEB-2024": KPIData(month: .feb, year: .year2021, rawValue: 150.0, formattedNumber: 150.0, valueLabel: "150", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAR-2024": KPIData(month: .mar, year: .year2021, rawValue: 180.0, formattedNumber: 180.0, valueLabel: "180", unit: .thousands, isIncreasing: false, isPositiveSentiment: false),
        "APR-2024": KPIData(month: .apr, year: .year2021, rawValue: 160.0, formattedNumber: 160.0, valueLabel: "160", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "MAY-2024": KPIData(month: .may, year: .year2021, rawValue: 140.0, formattedNumber: 140.0, valueLabel: "140", unit: .thousands, isIncreasing: false, isPositiveSentiment: true),
        "JUN-2024": KPIData(month: .jun, year: .year2021, rawValue: 130.0, formattedNumber: 130.0, valueLabel: "130", unit: .thousands, isIncreasing: false, isPositiveSentiment: true)
      ]
    ]
  }
  
}

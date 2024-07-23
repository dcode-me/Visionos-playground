//
//  DashboardView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct DashboardView: View {
  @StateObject private var calendarViewModel = CalendarViewModel()
  @State private var selectedYear: Int = 2024
  @State private var selectedMonth: String = "JUN" 
  @StateObject private var viewModel: KPIViewModel
  @State private var showCalendar = false
  
  init() {
    let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM-yyyy"
    let defaultMonthYear = dateFormatter.string(from: previousMonthDate)
    _viewModel = StateObject(wrappedValue: KPIViewModel(monthYear: defaultMonthYear))
  }
  
  func fetchGraphData(_ graphValues: [GraphValues]) -> [GraphValues]{
    var resultGraph = graphValues
    let currentMonth = graphValues.first { $0.monthIndex == 1 }
    let lastMonth = graphValues.first { $0.monthIndex == 2 }
    let month = currentMonth!.month
    let delta = currentMonth!.formattedNumber - lastMonth!.formattedNumber
    var deltaValue: GraphValues
    if delta > 0 {
      deltaValue = GraphValues(monthIndex: 0, month:month, formattedNumber: abs(delta), type: .deltaPositive)
    }
    else {
      deltaValue = GraphValues(monthIndex: 0, month:month, formattedNumber: abs(delta), type: .deltaNegative)
    }
    resultGraph.append(deltaValue)
    let sortedArray = resultGraph.sorted { $0.monthIndex > $1.monthIndex }
    print(sortedArray)
    return sortedArray
  }
  
  private func updateKPIViewModel() {
    let newDate = "\(selectedMonth)-\(selectedYear)"
    viewModel.selectedMonthYear = newDate
  }
  
  
  var body: some View {
    NavigationView {
      HStack(alignment: .top, spacing: 32){
        VStack(alignment: .leading, spacing: 32){
          HStack(spacing: 32) {
            if let revenueCADData = viewModel.allKPIData[KPIName.revenueCAD]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.revenueCAD]?.pastSixMonthsData{
              RevenueKPI(KPIDataSet: revenueCADData, graphData: fetchGraphData(graphValues), title: KPIName.revenue.rawValue, image: .canada_flag, subTitle: "in millions", prefix: "$").frame(width: 234).cornerRadius(12)
            }
            if let revenueUSData = viewModel.allKPIData[KPIName.revenueUSD]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.revenueUSD]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: revenueUSData, graphData: fetchGraphData(graphValues), title: KPIName.revenue.rawValue, image: .usa_flag, subTitle: "in millions", prefix: "$").frame(width: 234).cornerRadius(12)
            }
            if let successfulLoginData = viewModel.allKPIData[KPIName.sucessfulLogins]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.sucessfulLogins]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: successfulLoginData, graphData: fetchGraphData(graphValues), title: KPIName.sucessfulLogins.rawValue, subTitle: "in millions").frame(width: 234).cornerRadius(12)
            }
          }
          
          HStack(alignment: .top, spacing: 32) {
            if let avgrevenueCADData = viewModel.allKPIData[KPIName.avgRevenueCAD]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.avgRevenueCAD]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: avgrevenueCADData, graphData: fetchGraphData(graphValues), title: KPIName.avgRevenueCAD.rawValue, image: .canada_flag, subTitle: "per active customers", prefix: "$").frame(width: 234).cornerRadius(12)
            }
            if let avgrevenueUSData = viewModel.allKPIData[KPIName.avgRevenueUSD]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.avgRevenueUSD]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: avgrevenueUSData, graphData: fetchGraphData(graphValues), title: KPIName.avgRevenueUSD.rawValue, image: .usa_flag, subTitle: "per active customers", prefix: "$").frame(width: 234).cornerRadius(12)
            }
            if let uniqueUsersData = viewModel.allKPIData[KPIName.uniqueUsers]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.uniqueUsers]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: uniqueUsersData, graphData: fetchGraphData(graphValues), title: KPIName.uniqueUsers.rawValue).frame(width: 234).cornerRadius(12)
            }
          }
          
          HStack(spacing: 32) {
            if let HDCallsData = viewModel.allKPIData[KPIName.helpdeskCalls]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.helpdeskCalls]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: HDCallsData, graphData: fetchGraphData(graphValues), title: KPIName.helpdeskCalls.rawValue).frame(width: 234).cornerRadius(12)
            }
            if let SNticketsData = viewModel.allKPIData[KPIName.servicenowTickets]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.servicenowTickets]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: SNticketsData, graphData: fetchGraphData(graphValues), title: KPIName.servicenowTickets.rawValue).frame(width: 234).cornerRadius(12)
            }
            if let helpCenterData = viewModel.allKPIData[KPIName.helpcenter]?.currentMonthData, let graphValues =  viewModel.allKPIData[KPIName.helpcenter]?.pastSixMonthsData {
              RevenueKPI(KPIDataSet: helpCenterData, graphData: fetchGraphData(graphValues), title: KPIName.helpcenter.rawValue).frame(width: 234).cornerRadius(12)
            }
            
          }
        }
        VStack(alignment: .leading){
          UserSatisfactionScoreView()
          Button("Test"){
            selectedMonth = "MAY"
            selectedYear = 2024
            let newDate = "\(selectedMonth)-\(selectedYear)"
                viewModel.selectedMonthYear = newDate
          }
        }.frame(width:754)
      }
      .sheet(isPresented: $showCalendar, content: {
              CalendarView(selectedYear: $selectedYear, selectedMonth: $selectedMonth, onConfirm: { year, month in
                self.selectedYear = year
                self.selectedMonth = month
                updateKPIViewModel()
              })
            })
      .navigationTitle("AIDE").frame(width: 0.0, height: 100)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {
            showCalendar = true
            print("Button with SF Symbol tapped")
          }) {
            HStack {
              Image(systemName: "calendar")
              Text("\(selectedMonth.uppercased()) \(String(selectedYear))")
            }
          }
        }
      }
    }.navigationViewStyle(StackNavigationViewStyle())
  }
  
}

#Preview {
  DashboardView().frame(width: 1600, height: 900)
}

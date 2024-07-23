//
//  RevenueKPI.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-17.
//

import SwiftUI

struct RevenueKPI: View {
  var KPIDataSet: KPIData
  var graphData: [GraphValues]
  var title: String
  var image: ImageAsset?
  var subTitle: String? = " "
  var prefix: String?
  
  
  
  var body: some View {
    let majorValue: String = String(KPIDataSet.formattedNumber)
    let minorValue: String = KPIDataSet.unit.rawValue
    let trend: SFSymbol = KPIDataSet.isIncreasing ? .trendUpArrow : .trendDownArrow
    let trendColor: Colors = KPIDataSet.isPositiveSentiment ? .postiveFeedback : .negativeFeedback
    
    VStack(alignment: .leading, spacing: 24) {
      VStack(alignment: .leading, spacing: 4){
        if let flagImag = image {
          ImageTitle(text: title, imageAsset: flagImag)
        }
        else {
          Text(title)
            .font(.headline)
            .bold()
        }
        subTitleText(text: subTitle ?? " ")
      }
      if let prefixText = prefix {
        kpiValue(prefix: prefixText, majorValue: majorValue, minorValue: minorValue, symbol: trend, symbolColor: trendColor)
      }
      else {
        kpiValue(majorValue: majorValue, minorValue: minorValue, symbol: trend, symbolColor: trendColor)
      }
      BarChartView(barData: graphData)
    }
    .padding(16)
    .frame(alignment: .topLeading)
    .background(Color(hex: "#000000", opacity: 0.3))
    .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16),displayMode: .always)
  }
}



#Preview {
  RevenueKPI(KPIDataSet: KPIData(month: .apr, year: .year2021, rawValue: 6500.0, formattedNumber: 6.5, valueLabel: "6.5K", unit: .thousands, isIncreasing: true, isPositiveSentiment: true), graphData: [], title: "Revenue")
}

//
//  RevenueKPI.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-17.
//

import SwiftUI

struct RevenueKPI: View {
  var body: some View {
    let title: String = KPIName.revenue.rawValue
    let image: ImageAsset = .canada_flag
    let subTitle: String = "in millions"
    let majorValue: String = "17"
    let minorValue: String = ".7MM"
    let trend:SFSymbol = .trendUpArrow
    let trendColor: Colors = .postiveFeedback
    
      VStack(alignment: .leading, spacing: 24) {
        VStack(alignment: .leading, spacing: 4){
          ImageTitle(text: title, imageAsset: image)
          subTitleText(text: subTitle)
        }
        kpiValue(majorValue: majorValue, minorValue: minorValue, symbol: trend, symbolColor: trendColor)
        BarChartView()
      }
      .padding(16)
      .frame(alignment: .topLeading)
      .background(Color(hex: "#000000", opacity: 0.3))
      .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16),displayMode: .always)
  }
}



#Preview {
  RevenueKPI()
}

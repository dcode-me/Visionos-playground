//
//  KPIViews.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-15.
//

import SwiftUI

struct KPIViews: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct kpiValue: View {
  var prefix: String?
  //  var minorValueColor: Colors = .secondaryText
  var majorValue: String
  var minorValue: String
  var symbol: SFSymbol
  var symbolColor: Colors
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 0) {
      if let prefixValue = prefix {
        prefixText(text: prefixValue, padding: 8)
      }
      majorValueText(text: majorValue)
      minorValueText(text: minorValue, padding: 8)
        .padding(.trailing, 8)
      symbol.image(withColor: symbolColor)
        .padding(.vertical, 12)
    }
  }
}


#Preview {
  VStack{
    KPIViews()
    kpiValue(prefix: "$", majorValue: "17", minorValue: ".23 MM", symbol: .trendUpArrow, symbolColor: .postiveFeedback)
  }
  
}

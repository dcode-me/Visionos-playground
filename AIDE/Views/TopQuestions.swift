//
//  TopQuestions.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-18.
//

import SwiftUI

struct TopQuestions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct top3ValuesatsView : View {
  var majorValue: String
  var minorValue: String
  var title: String
  var body: some View {
    VStack(alignment: .leading, spacing: 16){
      HStack(alignment:.bottom, spacing:0) {
        majorValueText(text: majorValue)
        minorValueText(text: minorValue, padding: 8)
      }
      Text(title)
    }
    .padding(.vertical, 16) // Vertical padding
    .padding(.horizontal, 12)
    .background(Color(hex: "#808080", opacity: 0.3))
    .cornerRadius(4.0)
  }
}

#Preview {
    TopQuestions()
}

//
//  UserSatisfactionScoreView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-18.
//

import SwiftUI

struct UserSatisfactionScoreView: View {
  var body: some View {
      VStack(alignment:.leading, spacing: 24){
        Text("User Satisfaaction Scores")
        HStack(spacing:16){
          satsView(majorValue: "4.59", minorValue: "/5", title: "EFT")
          satsView(majorValue: "4.59", minorValue: "/5", title: "Interac e-transfer")
          satsView(majorValue: "4.59", minorValue: "/5", title: "Single Wire Payment")
          satsView(majorValue: "4.59", minorValue: "/5", title: "Account Transfer")
        }
      }.padding(16).background(Color(hex: "#000000", opacity: 0.3)).glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16),displayMode: .always)
   
  }
}

struct satsView : View {
  var majorValue: String
  var minorValue: String
  var title: String
  var body: some View {
    VStack(alignment: .leading, spacing: 16){
      HStack(alignment:.bottom, spacing:0) {
        majorValueText(text: majorValue)
        minorValueText(text: minorValue, padding: 8)
      }
      Text(title).fontWeight(.light)
    }
    .padding(.vertical, 16) // Vertical padding
    .padding(.horizontal, 12)
    .background(Color(hex: "#FFFFFF", opacity: 0.1))
    .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 4),displayMode: .implicit)
  }
}

#Preview {
  VStack{
    UserSatisfactionScoreView()
    satsView(majorValue: "4.59", minorValue: "/5", title: "Electronic Fund Transfer")
  }
}

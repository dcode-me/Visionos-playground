//
//  DashboardView.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

struct DashboardView: View {
  var body: some View {
    NavigationView {
      HStack(alignment: .top, spacing: 32){
        VStack(alignment: .leading, spacing: 32){
          HStack(spacing: 32) {
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
          }
          
          HStack(alignment: .top, spacing: 32) {
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
          }
          
          HStack(spacing: 32) {
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
            RevenueKPI().frame(width: 234).cornerRadius(12)
          }
        }
        VStack(alignment: .leading){
          UserSatisfactionScoreView()
        }.frame(width:754)
      }
      
      .navigationTitle("AIDE").frame(width: 0.0, height: 100)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {
            print("Button with SF Symbol tapped")
          }) {
            HStack {
              Image(systemName: "calendar")
              Text("JUNE 2024")
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

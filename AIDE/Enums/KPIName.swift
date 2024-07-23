//
//  KPITitle.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

import Foundation

enum KPIName: String, CaseIterable, Identifiable {
  case revenueCAD = "Revenue CAD"
  case revenue = "Revenue"
  case revenueUSD = "Revenue USD"
  case sucessfulLogins = "Successful Logins"
  case avgRevenueCAD = "Avg Revenue CAD"
  case avgRevenueUSD = "Avg Revenue USD"
  case avgRevenue = "Avg Revenue"
  case uniqueUsers  = "Unique Users"
  case helpdeskCalls = "Helpdesk Calls"
  case servicenowTickets = "Servicenow Tickets"
  case helpcenter = "Help Center"
  
  var id: String { self.rawValue }
}

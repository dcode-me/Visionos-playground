//
//  NumberUnit.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-16.
//

import Foundation

import Foundation
import SwiftUI

enum Unit: String, CaseIterable, Identifiable {
  case thousands = "K"
  case million = "MM"
  
  var id: String { self.rawValue }
}

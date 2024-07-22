//
//  Colors.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-15.
//

import SwiftUI

enum Colors {
  case primary
  case secondary
  case negativeFeedback
  case secondaryText
  case postiveFeedback
  case custom(Color)
  
  var color: Color {
    switch self {
    case .primary:
      return .blue // Example primary color
    case .secondary:
      return .green // Example secondary color
    case .negativeFeedback:
      return .red
    case .secondaryText:
      return Color.gray
    case .postiveFeedback:
      return .green
    case .custom(let customColor):
      return customColor
    }
  }
}

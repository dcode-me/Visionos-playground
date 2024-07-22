//
//  Year.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import Foundation
import SwiftUI

enum Year: Int, CaseIterable, Identifiable {
  case year2021 = 2021
  case year2022 = 2022
  case year2023 = 2023
  case year2024 = 2024
  
  var id: Int { self.rawValue }
}

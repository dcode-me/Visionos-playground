//
//  Month.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import Foundation
import SwiftUI

enum Month: String, CaseIterable, Identifiable {
    case jan = "JAN"
    case feb = "FEB"
    case mar = "MAR"
    case apr = "APR"
    case may = "MAY"
    case jun = "JUN"
    case jul = "JUL"
    case aug = "AUG"
    case sep = "SEP"
    case oct = "OCT"
    case nov = "NOV"
    case dec = "DEC"

    var id: String { self.rawValue }
}

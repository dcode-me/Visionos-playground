//
//  ImageAsset.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

enum ImageAsset: String {
    case canada_flag = "Canada"
    case usa_flag = "USA"

    var image: Image {
        return Image(self.rawValue)
    }
}

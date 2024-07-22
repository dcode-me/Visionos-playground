//
//  SFSymbol.swift
//  AIDE
//
//  Created by ilakkiaselvan subbiah on 2024-07-14.
//

import SwiftUI

enum SFSymbol: String {
    case star = "star.fill"
    case heart = "heart.fill"
    case bell = "bell.fill"
    case logo = "applelogo"
    case trendUpArrow = "arrow.up.circle"

    func image(withColor color: Colors = .primary, size: CGFloat = 24) -> some View {
        Image(systemName: self.rawValue)
            .resizable()
            .scaledToFit()
            .foregroundColor(color.color) // Use the color from the Colors enum
            .frame(width: size, height: size)
    }
}

//
//  Extensions.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 22.10.21.
//

import Foundation
import SwiftUI

// MARK: - Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

// MARK: - SwiftUI

extension Color {
    static func fromString(_ string: String) -> Color {
        switch string {
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        case "green":
            return .green
        case "red":
            return .red
        case "orange":
            return .orange
        default:
            return .init(
                red: Double.random(in: 0..<255),
                green: Double.random(in: 0..<255),
                blue: Double.random(in: 0..<255)
            )
        }
    }
}

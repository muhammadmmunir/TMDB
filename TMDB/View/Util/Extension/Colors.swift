//
//  Colors.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

extension Color {
    /// Hex: #db0000
    static let tRed = Color(hex: "#db0000")
    /// Hex: #000000
    static let tBlack = Color(hex: "#000000")
    /// Hex: #ffffff
    static let tWhite = Color(hex: "#ffffff")
    /// Hex: #564d4d
    static let tEmperor = Color(hex: "#564d4d")
    /// Hex: #831010
    static let tTamarillo = Color(hex: "#831010")
    /// Hex: #1f1f1f
    static let tDarkGray = Color(hex: "1f1f1f")
    /// Hex: #B2B2B2
    static let tLightGray = Color(hex: "B2B2B2")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

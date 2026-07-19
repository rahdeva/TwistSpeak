//
//  Theme.swift
//  TwistSpeak
//
//  Design tokens derived from the TwistSpeak prototype board.
//

import SwiftUI

extension Color {
    init(hex: UInt32, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

/// Central palette + type scale mirroring the design system screen of the prototype.
enum TS {

    // MARK: Brand & semantic colors
    static let primary = Color(hex: 0x4B5BF0)
    static let primaryDark = Color(hex: 0x3341C8)
    static let purple = Color(hex: 0x7A5AF8)
    static let correct = Color(hex: 0x17B26A)
    static let correctDeep = Color(hex: 0x0E8F52)
    static let practice = Color(hex: 0xF79009)
    static let practiceDeep = Color(hex: 0xB26A00)
    static let error = Color(hex: 0xE5484D)
    static let errorDeep = Color(hex: 0xC9333A)
    static let goldPB = Color(hex: 0xE7A600)

    // MARK: Neutrals
    static let ink = Color(hex: 0x14161D)
    static let ink2 = Color(hex: 0x1E2130)
    static let textSecondary = Color(hex: 0x5C6172)
    static let textBody = Color(hex: 0x3B4050)
    static let muted = Color(hex: 0x8A8FA0)
    static let mutedLight = Color(hex: 0xA2A7B8)
    static let surface = Color(hex: 0xF4F5FA)
    static let appBackground = Color(hex: 0xF4F5FA)
    static let card = Color.white
    static let cardBorder = Color(hex: 0xEDEFF6)
    static let hairline = Color(hex: 0xE4E7F0)
    static let track = Color(hex: 0xEEF0F6)

    // MARK: Tinted surfaces
    static let primaryTint = Color(hex: 0xEEF0FE)
    static let purpleTint = Color(hex: 0xF3ECFF)
    static let correctTint = Color(hex: 0xE7F7EF)
    static let correctTintBorder = Color(hex: 0xB9EAD1)
    static let practiceTint = Color(hex: 0xFEF1E1)
    static let practiceTintBorder = Color(hex: 0xF6DDBB)
    static let errorTint = Color(hex: 0xFDECEC)
    static let uncertainTint = Color(hex: 0xF1F2F8)
    static let goldTint = Color(hex: 0xFBF7E8)
    static let goldTintBorder = Color(hex: 0xF1E6BE)

    // MARK: Gradients
    static let brandGradient = LinearGradient(
        colors: [primary, purple],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let brandGradientReversed = LinearGradient(
        colors: [purple, primary],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let correctGradient = LinearGradient(
        colors: [correct, Color(hex: 0x3ED08A)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let goldGradient = LinearGradient(
        colors: [goldPB, Color(hex: 0xF6C445)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let practiceGradient = LinearGradient(
        colors: [practice, Color(hex: 0xF6C445)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let splashGradient = LinearGradient(
        colors: [primary, purple],
        startPoint: .top, endPoint: .bottom
    )
}

// MARK: - Typography

extension Font {
    static let tsDisplay = Font.system(size: 28, weight: .heavy, design: .rounded)
    static let tsTitle = Font.system(size: 25, weight: .heavy, design: .rounded)
    static let tsTitle2 = Font.system(size: 22, weight: .bold, design: .rounded)
    static let tsHeadline = Font.system(size: 18, weight: .heavy, design: .rounded)
    static let tsBody = Font.system(size: 16, weight: .regular)
    static let tsBodyMedium = Font.system(size: 16, weight: .semibold)
    static let tsCallout = Font.system(size: 15, weight: .regular)
    static let tsCaption = Font.system(size: 13, weight: .bold)
    static let tsMicro = Font.system(size: 11, weight: .bold)
}

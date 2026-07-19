//
//  Components.swift
//  TwistSpeak
//
//  Reusable building blocks matching the prototype's component language.
//

import SwiftUI

// MARK: - Card container

struct TSCard<Content: View>: View {
    var padding: CGFloat = 16
    var cornerRadius: CGFloat = 18
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(TS.card, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(TS.cardBorder, lineWidth: 1)
            )
            .shadow(color: TS.ink.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Buttons

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var background: Color = TS.primary
    var height: CGFloat = 54
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemImage { Image(systemName: systemImage) }
                Text(title)
            }
            .font(.system(size: 17, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: background.opacity(0.5), radius: 14, x: 0, y: 10)
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryButton: View {
    let title: String
    var systemImage: String? = nil
    var height: CGFloat = 54
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage { Image(systemName: systemImage) }
                Text(title)
            }
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundStyle(TS.textBody)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(TS.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(TS.hairline, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct GhostButton: View {
    let title: String
    var color: Color = TS.muted
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
        }
        .buttonStyle(.plain)
    }
}

/// Small "‹ Back" style leading nav button.
struct BackLink: View {
    var title: String = "Back"
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                Text(title)
            }
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(TS.muted)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Pills & chips

struct Pill: View {
    let text: String
    var fg: Color = TS.textSecondary
    var bg: Color = TS.card
    var bordered: Bool = true

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundStyle(fg)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(bg, in: Capsule())
            .overlay(bordered ? Capsule().stroke(TS.hairline, lineWidth: 1) : nil)
    }
}

struct TagChip: View {
    let text: String
    var fg: Color = TS.textSecondary
    var bg: Color = TS.uncertainTint
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundStyle(fg)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(bg, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

// MARK: - Progress bar

struct TSProgressBar: View {
    var value: Double            // 0...1
    var height: CGFloat = 6
    var fill: LinearGradient = TS.brandGradient
    var track: Color = TS.track

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(track)
                Capsule().fill(fill)
                    .frame(width: max(0, min(1, value)) * geo.size.width)
            }
        }
        .frame(height: height)
    }
}

// MARK: - Stat tile

struct StatTile: View {
    let caption: String
    let value: String
    var valueColor: Color = TS.ink
    var body: some View {
        TSCard(padding: 14, cornerRadius: 15) {
            VStack(alignment: .leading, spacing: 3) {
                Text(caption.uppercased())
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(TS.muted)
                Text(value)
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundStyle(valueColor)
            }
        }
    }
}

// MARK: - Section header

struct SectionLabel: View {
    let text: String
    var color: Color = TS.muted
    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 13, weight: .heavy, design: .rounded))
            .tracking(0.5)
            .foregroundStyle(color)
    }
}

// MARK: - Star row

struct StarRow: View {
    let filled: Int
    var total: Int = 3
    var size: CGFloat = 15
    var color: Color = TS.practice
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<total, id: \.self) { i in
                Image(systemName: "star.fill")
                    .font(.system(size: size))
                    .foregroundStyle(i < filled ? color : TS.hairline)
            }
        }
    }
}

// MARK: - Ring gauge

struct RingGauge: View {
    var progress: Double         // 0...1
    var lineWidth: CGFloat = 11
    var color: Color = TS.correct
    var track: Color = TS.track
    var centerTop: String
    var centerBottom: String
    var centerColor: Color = TS.correct

    var body: some View {
        ZStack {
            Circle().stroke(track, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: max(0, min(1, progress)))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 0) {
                Text(centerTop)
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(centerColor)
                Text(centerBottom.uppercased())
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundStyle(TS.muted)
            }
        }
    }
}

// MARK: - Icon badge (rounded tinted square with SF Symbol)

struct IconBadge: View {
    let systemName: String
    var tint: Color = TS.primary
    var background: Color = TS.primaryTint
    var size: CGFloat = 46
    var corner: CGFloat = 13
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: size * 0.46, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: size, height: size)
            .background(background, in: RoundedRectangle(cornerRadius: corner, style: .continuous))
    }
}

// MARK: - Info callout

struct Callout: View {
    let text: String
    var systemImage: String = "checkmark"
    var tint: Color = TS.correct
    var bg: Color = TS.surface
    var border: Color = TS.hairline
    var textColor: Color = TS.textBody

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(tint)
            Text(text)
                .font(.system(size: 14))
                .foregroundStyle(textColor)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bg, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(border, lineWidth: 1))
    }
}

// MARK: - Animated wordmark logo

struct WordmarkLogo: View {
    var size: CGFloat = 40
    var bars: [CGFloat] = [0.28, 0.48, 0.20]
    var body: some View {
        RoundedRectangle(cornerRadius: size * 0.3, style: .continuous)
            .fill(TS.brandGradient)
            .frame(width: size, height: size)
            .overlay(
                HStack(spacing: size * 0.06) {
                    ForEach(bars.indices, id: \.self) { i in
                        Capsule().fill(.white)
                            .frame(width: size * 0.075, height: size * bars[i])
                    }
                }
            )
    }
}

// MARK: - Screen background

struct ScreenBackground: ViewModifier {
    func body(content: Content) -> some View {
        content.background(TS.appBackground.ignoresSafeArea())
    }
}

extension View {
    func screenBackground() -> some View { modifier(ScreenBackground()) }
}

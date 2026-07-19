//
//  ChallengeModeViews.swift
//  TwistSpeak
//
//  Accuracy, Speed, Daily Twist and Mistake Review (PRD §17.8–17.12).
//

import SwiftUI

// MARK: - Accuracy Challenge

struct AccuracyChallengeView: View {
    @Environment(AppState.self) private var app
    let twister: TongueTwister

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                heroBanner(
                    kicker: "Accuracy Challenge",
                    title: "Clear before fast",
                    body: "Speed doesn't matter here. Say every word clearly and completely — retry as many times as you like, no penalty.",
                    gradient: TS.correctGradient, ink: .white)

                TSCard(padding: 18, cornerRadius: 20) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Mastery requirements").font(.system(size: 14, weight: .heavy, design: .rounded))
                        requirement("Word Accuracy", "92% / 90%", 0.92, TS.correct)
                        requirement("Completion", "100% / 95%", 1.0, TS.correct)
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Words still to master").font(.system(size: 14, weight: .bold, design: .rounded))
                                Spacer()
                                Text("2 left").font(.system(size: 14, weight: .bold, design: .rounded)).foregroundStyle(TS.practice)
                            }
                            HStack(spacing: 6) {
                                ForEach(0..<6, id: \.self) { i in
                                    Capsule().fill(i < 4 ? TS.correct : TS.practice).frame(height: 9)
                                }
                            }
                        }
                    }
                }

                Callout(text: "Retry costs nothing. Every attempt only helps you improve.",
                        systemImage: "heart.fill", tint: TS.correctDeep,
                        bg: TS.correctTint, border: TS.correctTintBorder, textColor: TS.correctDeep)
            }
            .padding(.horizontal, 20).padding(.bottom, 100)
        }
        .background(TS.appBackground)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Start accuracy run", background: TS.correct) {
                app.activeTwister = twister
                app.push(.listen(twister))
            }
            .padding(.horizontal, 20).padding(.vertical, 12).background(.ultraThinMaterial)
        }
        .navigationTitle("Accuracy Challenge").navigationBarTitleDisplayMode(.inline)
    }

    private func requirement(_ title: String, _ value: String, _ progress: Double, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title).font(.system(size: 14, weight: .bold, design: .rounded))
                Spacer()
                Text(value).font(.system(size: 14, weight: .bold, design: .rounded)).foregroundStyle(color)
            }
            TSProgressBar(value: progress, height: 9,
                          fill: LinearGradient(colors: [color, color], startPoint: .leading, endPoint: .trailing))
        }
    }
}

// MARK: - Speed Challenge

struct SpeedChallengeView: View {
    @Environment(AppState.self) private var app
    let twister: TongueTwister

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ZStack(alignment: .topTrailing) {
                    Pill(text: "✓ Unlocked", fg: .white, bg: .white.opacity(0.22), bordered: false)
                        .padding(20)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("SPEED CHALLENGE")
                            .font(.system(size: 13, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white.opacity(0.9))
                        Text("Beat the clock — clearly")
                            .font(.system(size: 24, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                        HStack(spacing: 20) {
                            metric("Target time", "\(String(format: "%.1f", twister.targetDuration))s")
                            metric("Your best", "6.1s")
                        }
                        .padding(.top, 18)
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(TS.brandGradient, in: RoundedRectangle(cornerRadius: 22, style: .continuous))

                TSCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            Text("🛡️").font(.system(size: 18))
                                .frame(width: 34, height: 34)
                                .background(TS.primaryTint, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Text("Accuracy protection").font(.system(size: 14, weight: .heavy, design: .rounded))
                        }
                        Text("Speed only counts when your accuracy stays above 85% and completion above 90%. A fast attempt with missing words won't earn a top score.")
                            .font(.system(size: 14)).foregroundStyle(TS.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                        thresholdBar
                    }
                }
            }
            .padding(.horizontal, 20).padding(.bottom, 100)
        }
        .background(TS.appBackground)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Start speed run") {
                app.activeTwister = twister
                app.push(.listen(twister))
            }
            .padding(.horizontal, 20).padding(.vertical, 12).background(.ultraThinMaterial)
        }
        .navigationTitle("Speed Challenge").navigationBarTitleDisplayMode(.inline)
    }

    private func metric(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label.uppercased()).font(.system(size: 12, weight: .bold, design: .rounded)).foregroundStyle(.white.opacity(0.85))
            Text(value).font(.system(size: 26, weight: .heavy, design: .rounded)).foregroundStyle(.white)
        }
    }

    private var thresholdBar: some View {
        VStack(spacing: 5) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(LinearGradient(colors: [TS.error, TS.practice, TS.correct], startPoint: .leading, endPoint: .trailing))
                    Rectangle().fill(TS.ink).frame(width: 2, height: 15)
                        .offset(x: geo.size.width * 0.85, y: -3)
                }
            }
            .frame(height: 9)
            HStack {
                Text("Speed paused"); Spacer(); Text("85% threshold"); Spacer(); Text("Speed counts")
            }
            .font(.system(size: 11, weight: .bold, design: .rounded)).foregroundStyle(TS.muted)
        }
        .padding(.top, 6)
    }
}

// MARK: - Daily Twist

struct DailyTwistView: View {
    @Environment(AppState.self) private var app
    private var daily: TongueTwister { SampleData.daily }
    private let days = [("Mon", true), ("Tue", true), ("Wed", false), ("Thu", true), ("Fri", true), ("Today", false)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ZStack(alignment: .topLeading) {
                    Circle().fill(.white.opacity(0.12)).frame(width: 120, height: 120).offset(x: 240, y: -20)
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 8) {
                            Text("📅").font(.system(size: 20))
                            Text("DAILY TWIST · TODAY")
                                .font(.system(size: 13, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                        }
                        Text("\"\(daily.text.replacingOccurrences(of: "?", with: "?"))\"")
                            .font(.system(size: 23, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                            .fixedSize(horizontal: false, vertical: true)
                        HStack(spacing: 8) {
                            Pill(text: daily.difficulty.rawValue, fg: .white, bg: .white.opacity(0.22), bordered: false)
                            Pill(text: "~2 min", fg: .white, bg: .white.opacity(0.22), bordered: false)
                            Pill(text: "+30 bonus", fg: Color(hex: 0x3A2E00), bg: Color(hex: 0xF6C445), bordered: false)
                        }
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(TS.brandGradientReversed, in: RoundedRectangle(cornerRadius: 24, style: .continuous))

                TSCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Your streak").font(.system(size: 14, weight: .heavy, design: .rounded))
                            Spacer()
                            Text("\(app.progress.streakCount) days 🔥").font(.system(size: 14, weight: .heavy, design: .rounded)).foregroundStyle(TS.practice)
                        }
                        HStack(spacing: 6) {
                            ForEach(Array(days.enumerated()), id: \.offset) { _, day in
                                streakDay(day.0, done: day.1, isToday: day.0 == "Today")
                            }
                        }
                        Text("Missed Wednesday? No worries — your progress is safe and your streak keeps its best run.")
                            .font(.system(size: 13)).foregroundStyle(TS.muted).multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 20).padding(.bottom, 100)
        }
        .background(TS.appBackground)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Do today's Twist", background: TS.purple) {
                app.activeTwister = daily
                app.push(.listen(daily))
            }
            .padding(.horizontal, 20).padding(.vertical, 12).background(.ultraThinMaterial)
        }
        .navigationTitle("Daily Twist").navigationBarTitleDisplayMode(.inline)
    }

    private func streakDay(_ label: String, done: Bool, isToday: Bool) -> some View {
        VStack(spacing: 4) {
            ZStack {
                Circle().fill(isToday ? Color.white : (done ? TS.practice : Color(hex: 0xEDEFF4)))
                    .frame(width: 32, height: 32)
                if isToday {
                    Circle().stroke(style: StrokeStyle(lineWidth: 2, dash: [3])).foregroundStyle(TS.primary).frame(width: 32, height: 32)
                    Text("·").font(.system(size: 16, weight: .heavy)).foregroundStyle(TS.primary)
                } else {
                    Text(done ? "✓" : "—").font(.system(size: 13, weight: .heavy)).foregroundStyle(done ? .white : Color(hex: 0xB9BDCB))
                }
            }
            Text(label).font(.system(size: 11, weight: isToday ? .bold : .semibold, design: .rounded))
                .foregroundStyle(isToday ? TS.primary : TS.muted)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Mistake Review

struct MistakeReviewView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Mistake Review").font(.tsTitle)
                    Text("Personalised practice picks — not failures. Little wins add up.")
                        .font(.system(size: 14)).foregroundStyle(TS.textSecondary)
                }

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Ready to review").font(.system(size: 14, weight: .semibold)).foregroundStyle(.white.opacity(0.9))
                        Text("8 words · 3 twisters").font(.system(size: 22, weight: .heavy, design: .rounded)).foregroundStyle(.white)
                    }
                    Spacer()
                    Button("Start ▸") {
                        app.activeTwister = SampleData.seashore
                        app.push(.difficultWord)
                    }
                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                    .foregroundStyle(TS.primary)
                    .padding(.horizontal, 16).frame(height: 44)
                    .background(.white, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .buttonStyle(.plain)
                }
                .padding(16)
                .background(TS.brandGradient, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(color: TS.primary.opacity(0.4), radius: 14, y: 12)

                SectionLabel(text: "Frequently missed words").padding(.top, 4)

                ForEach(SampleData.missedWords) { mw in
                    MissedWordRow(missed: mw) {
                        app.activeTwister = SampleData.seashore
                        app.push(.difficultWord)
                    }
                }
            }
            .padding(.horizontal, 20).padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationTitle("Mistake Review").navigationBarTitleDisplayMode(.inline)
    }
}

private struct MissedWordRow: View {
    let missed: MissedWord
    let action: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text(badgeText)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundStyle(badgeFg)
                .frame(width: 44, height: 44)
                .background(badgeBg, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(missed.word).font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundStyle(missed.trend == .mastered ? TS.correctDeep : TS.ink)
                    trendTag
                }
                Text(missed.trend == .mastered ? missed.note : "\(missed.sound) · \(missed.note)")
                    .font(.system(size: 13)).foregroundStyle(TS.muted)
            }
            Spacer()
            if missed.trend != .mastered {
                Button("Practice", action: action)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(TS.primary)
                    .padding(.horizontal, 12).frame(height: 36)
                    .background(TS.primaryTint, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .buttonStyle(.plain)
            }
        }
        .padding(14)
        .background(TS.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
    }

    private var badgeText: String { missed.trend == .mastered ? "✓" : "×\(missed.misses)" }
    private var badgeFg: Color {
        switch missed.trend {
        case .highPriority: return TS.errorDeep
        case .improving: return TS.practiceDeep
        case .mastered: return TS.correctDeep
        }
    }
    private var badgeBg: Color {
        switch missed.trend {
        case .highPriority: return TS.errorTint
        case .improving: return TS.practiceTint
        case .mastered: return TS.correctTint
        }
    }

    @ViewBuilder private var trendTag: some View {
        switch missed.trend {
        case .highPriority: TagChip(text: "High priority", fg: TS.errorDeep, bg: TS.errorTint)
        case .improving: TagChip(text: "↑ Improving", fg: TS.correctDeep, bg: TS.correctTint)
        case .mastered: TagChip(text: "Mastered!", fg: TS.correctDeep, bg: TS.correctTint)
        }
    }
}

/// Reusable gradient banner used by challenge-mode intros.
private func heroBanner(kicker: String, title: String, body: String, gradient: LinearGradient, ink: Color) -> some View {
    VStack(alignment: .leading, spacing: 8) {
        Text(kicker.uppercased())
            .font(.system(size: 13, weight: .heavy, design: .rounded)).foregroundStyle(ink.opacity(0.9))
        Text(title).font(.system(size: 24, weight: .heavy, design: .rounded)).foregroundStyle(ink)
        Text(body).font(.system(size: 15)).foregroundStyle(ink.opacity(0.92))
            .fixedSize(horizontal: false, vertical: true)
    }
    .padding(22)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(gradient, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
}

#Preview("Accuracy") {
    NavigationStack { AccuracyChallengeView(twister: SampleData.seashore) }
        .environment(AppState()).environment(SpeechService())
}

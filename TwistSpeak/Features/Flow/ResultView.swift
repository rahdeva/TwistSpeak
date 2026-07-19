//
//  ResultView.swift
//  TwistSpeak
//
//  The core screen: explains performance, not just a score (PRD §17.7).
//

import SwiftUI

private struct ResultStyle {
    var badge: String
    var headline: String
    var heroGradient: LinearGradient
    var heroInner: Color
    var heroInk: Color
    var ringColor: Color
    var starColor: Color
    var starLabel: String
    var showMetrics: Bool
    var showWords: Bool
    var showSuggest: Bool
    var note: (icon: String, title: String, body: String, bg: Color, border: Color, ink: Color)?
    var primaryCta: String
}

struct ResultView: View {
    @Environment(AppState.self) private var app

    private var attempt: PracticeAttempt? { app.lastAttempt }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                heroCard
                if style.showMetrics, let a = attempt { metrics(a) }
                if let note = style.note { noteCard(note) }
                if style.showWords, let a = attempt, !a.wordResults.isEmpty { wordsCard(a) }
                if style.showSuggest { suggestCard }
                actions
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Hero

    private var heroCard: some View {
        ZStack(alignment: .topLeading) {
            Circle().fill(.white.opacity(0.12)).frame(width: 130, height: 130).offset(x: 240, y: -24)
            VStack(alignment: .leading, spacing: 6) {
                Text(style.badge.uppercased())
                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                    .foregroundStyle(style.heroInk.opacity(0.92))
                Text(style.headline)
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(style.heroInk)

                HStack(spacing: 18) {
                    scoreRing
                    VStack(alignment: .leading, spacing: 10) {
                        StarRow(filled: min(3, starCount), total: 3, size: 26, color: style.starColor)
                        Text(style.starLabel)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(style.heroInk.opacity(0.92))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.top, 10)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(style.heroGradient, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: TS.ink.opacity(0.3), radius: 18, y: 14)
    }

    private var scoreRing: some View {
        ZStack {
            Circle().stroke(style.heroInk.opacity(0.28), lineWidth: 9)
            Circle()
                .trim(from: 0, to: ringProgress)
                .stroke(style.ringColor, style: StrokeStyle(lineWidth: 9, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 0) {
                Text(scoreText)
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundStyle(style.heroInk)
                Text("SCORE")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(style.heroInk.opacity(0.85))
            }
        }
        .frame(width: 96, height: 96)
    }

    // MARK: Metrics

    private func metrics(_ a: PracticeAttempt) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            metricTile("Word accuracy", "\(Int(a.wordAccuracy))%", color: accuracyColor(a.wordAccuracy))
            metricTile("Completion", "\(Int(a.completion))%")
            metricTile("Duration", "\(String(format: "%.1f", a.duration))s")
            metricTile("Words / min", "\(a.wordsPerMinute)")
        }
    }

    private func metricTile(_ caption: String, _ value: String, color: Color = TS.ink) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(caption.uppercased()).font(.system(size: 12, weight: .bold, design: .rounded)).foregroundStyle(TS.muted)
            Text(value).font(.system(size: 22, weight: .heavy, design: .rounded)).foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14).padding(.vertical, 13)
        .background(TS.card, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
    }

    // MARK: Note

    private func noteCard(_ note: (icon: String, title: String, body: String, bg: Color, border: Color, ink: Color)) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(note.icon).font(.system(size: 22))
            VStack(alignment: .leading, spacing: 3) {
                Text(note.title).font(.system(size: 15, weight: .heavy, design: .rounded)).foregroundStyle(note.ink)
                Text(note.body).font(.system(size: 14)).foregroundStyle(note.ink.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 16).padding(.vertical, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(note.bg, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(note.border, lineWidth: 1))
    }

    // MARK: Words

    private func wordsCard(_ a: PracticeAttempt) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            TSCard {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Your sentence").font(.system(size: 14, weight: .heavy, design: .rounded))
                        Spacer()
                        Button {
                            app.push(.listen(app.activeTwister))
                        } label: {
                            Text("▸ Listen again")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundStyle(TS.primary)
                                .padding(.horizontal, 12).padding(.vertical, 6)
                                .background(TS.primaryTint, in: Capsule())
                        }.buttonStyle(.plain)
                    }
                    FlowLayout(spacing: 6, lineSpacing: 8) {
                        ForEach(a.wordResults) { w in
                            HStack(spacing: 3) {
                                Text(w.word)
                                Text(w.status.glyph).font(.system(size: 11, weight: .heavy))
                            }
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundStyle(w.status.color)
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(w.status.tint, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                        }
                    }
                    Divider()
                    legend
                }
            }
            if !a.transcription.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    SectionLabel(text: "Recognized").font(.system(size: 12, weight: .bold))
                    Text("\"\(a.transcription)\"")
                        .font(.system(size: 15)).italic().foregroundStyle(TS.textBody)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14).padding(.vertical, 12)
                .background(Color(hex: 0xF8F9FC), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
                .padding(.top, 12)
            }
        }
    }

    private var legend: some View {
        FlowLayout(spacing: 12, lineSpacing: 6) {
            legendItem("Correct ✓", TS.correct)
            legendItem("Practice ~", TS.practice)
            legendItem("Missing ×", TS.error)
            legendItem("Uncertain ?", Color(hex: 0xC3C7D4))
        }
    }

    private func legendItem(_ text: String, _ color: Color) -> some View {
        HStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 3).fill(color).frame(width: 11, height: 11)
            Text(text).font(.system(size: 12, weight: .semibold)).foregroundStyle(TS.textSecondary)
        }
    }

    // MARK: Suggest

    private var suggestCard: some View {
        Button {
            app.push(.difficultWord)
        } label: {
            HStack(spacing: 12) {
                Text("🎯").font(.system(size: 22))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Practice these words")
                        .font(.system(size: 14, weight: .heavy, design: .rounded)).foregroundStyle(TS.practiceDeep)
                    Text(app.activeTwister.difficultWords.joined(separator: " · "))
                        .font(.system(size: 14)).foregroundStyle(Color(hex: 0x8A6A2A))
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(Color(hex: 0xD9A65C))
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(hex: 0xFEF7EC), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color(hex: 0xF6E2C2), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    // MARK: Actions

    private var actions: some View {
        HStack(spacing: 10) {
            Button {
                app.pop()   // back to record
            } label: {
                HStack(spacing: 8) { Image(systemName: "arrow.clockwise"); Text("Retry") }
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundStyle(TS.textBody)
                    .frame(maxWidth: .infinity).frame(height: 54)
                    .background(TS.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(TS.hairline, lineWidth: 1))
            }
            .buttonStyle(.plain)

            Button {
                app.resetActiveFlow()
                app.selectedTab = .home
            } label: {
                Text(style.primaryCta)
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 54)
                    .background(TS.primary, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: TS.primary.opacity(0.5), radius: 12, y: 8)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 4)
    }

    // MARK: Derived values

    private var starCount: Int { attempt?.starsEarned ?? 0 }

    private var scoreText: String {
        guard let a = attempt, style.showMetrics else { return "—" }
        return "\(a.overallScore)"
    }

    private var ringProgress: Double {
        guard let a = attempt, style.showMetrics else { return 0.44 }
        return Double(a.overallScore) / 100
    }

    private func accuracyColor(_ acc: Double) -> Color {
        if acc >= 85 { return TS.correct }
        if acc >= 65 { return TS.practice }
        return TS.error
    }

    // MARK: Variant styling

    private var style: ResultStyle {
        switch app.lastVariant {
        case .perfect:
            return ResultStyle(
                badge: "Perfect result", headline: "Perfect! Every word clear",
                heroGradient: TS.correctGradient, heroInner: Color(hex: 0x1CB870), heroInk: .white,
                ringColor: .white, starColor: Color(hex: 0xFFD54A),
                starLabel: "Perfect Star unlocked · +75 Twist Points",
                showMetrics: true, showWords: true, showSuggest: false, note: nil,
                primaryCta: "Next challenge ▸")
        case .best:
            return ResultStyle(
                badge: "New personal best", headline: "New personal best! 🎉",
                heroGradient: TS.goldGradient, heroInner: Color(hex: 0xE9AC12), heroInk: Color(hex: 0x3A2E00),
                ringColor: Color(hex: 0x3A2E00), starColor: Color(hex: 0x3A2E00),
                starLabel: "3 stars · beat your record!",
                showMetrics: true, showWords: true, showSuggest: false, note: nil,
                primaryCta: "Next challenge ▸")
        case .strong:
            return ResultStyle(
                badge: "Great clarity", headline: "Nice, clear attempt!",
                heroGradient: TS.brandGradient, heroInner: Color(hex: 0x5763E6), heroInk: .white,
                ringColor: .white, starColor: Color(hex: 0xFFD54A),
                starLabel: "Stars earned · keep it up!",
                showMetrics: true, showWords: true, showSuggest: true, note: nil,
                primaryCta: "Next challenge ▸")
        case .partial:
            return ResultStyle(
                badge: "Good effort", headline: "Almost there — try again",
                heroGradient: LinearGradient(colors: [Color(hex: 0x6B74E8), Color(hex: 0x8A7BF0)], startPoint: .topLeading, endPoint: .bottomTrailing),
                heroInner: Color(hex: 0x6E77E6), heroInk: .white,
                ringColor: .white, starColor: Color(hex: 0xFFD54A),
                starLabel: "Keep going, you improved!",
                showMetrics: true, showWords: true, showSuggest: true, note: nil,
                primaryCta: "Try again ▸")
        case .speedInvalid:
            return ResultStyle(
                badge: "Speed not counted", headline: "Clear first, fast second",
                heroGradient: LinearGradient(colors: [Color(hex: 0xE58A2A), Color(hex: 0xF5A524)], startPoint: .topLeading, endPoint: .bottomTrailing),
                heroInner: Color(hex: 0xE88F2E), heroInk: Color(hex: 0x3A2200),
                ringColor: Color(hex: 0x3A2200), starColor: Color(hex: 0x3A2200),
                starLabel: "Fast! But accuracy was too low to count the speed",
                showMetrics: true, showWords: true, showSuggest: true,
                note: ("⚡", "Speed score paused", "Speed only counts once accuracy is 85%+. Nail the words first, then chase the clock.",
                       TS.practiceTint, TS.practiceTintBorder, TS.practiceDeep),
                primaryCta: "Home")
        case .lowConfidence:
            return ResultStyle(
                badge: "Not fully sure", headline: "We didn't catch that clearly",
                heroGradient: LinearGradient(colors: [TS.muted, Color(hex: 0xA7ABBB)], startPoint: .topLeading, endPoint: .bottomTrailing),
                heroInner: Color(hex: 0x9297A7), heroInk: .white,
                ringColor: .white.opacity(0.55), starColor: .white.opacity(0.4),
                starLabel: "No penalty — this attempt does not count",
                showMetrics: false, showWords: true, showSuggest: false,
                note: ("🎧", "Recognition confidence was low", "Move a little closer to the mic and try again in a quieter spot. Nothing was counted against you.",
                       TS.surface, TS.hairline, TS.textBody),
                primaryCta: "Home")
        case .noSpeech:
            return ResultStyle(
                badge: "No speech detected", headline: "We didn't hear anything",
                heroGradient: LinearGradient(colors: [TS.muted, Color(hex: 0xA7ABBB)], startPoint: .topLeading, endPoint: .bottomTrailing),
                heroInner: Color(hex: 0x9297A7), heroInk: .white,
                ringColor: .white.opacity(0.4), starColor: .white.opacity(0.4),
                starLabel: "No penalty — let's try that again",
                showMetrics: false, showWords: false, showSuggest: false,
                note: ("🎙️", "No words came through", "Tap record, wait for the listening state, then say the whole sentence. Make sure nothing is covering the microphone.",
                       TS.surface, TS.hairline, TS.textBody),
                primaryCta: "Home")
        }
    }
}

#Preview {
    let app = AppState()
    app.lastAttempt = PracticeAttempt(
        tongueTwisterID: SampleData.seashore.id, transcription: "she sells seashell by the seashore",
        wordAccuracy: 92, completion: 100, duration: 6.8, wordsPerMinute: 53, overallScore: 88,
        starsEarned: 2, pointsEarned: 45, isPersonalBest: false, recognitionStatus: .success,
        wordResults: WordComparison.compare(target: SampleData.seashore.text, recognized: "she sells seashell by the seashore").wordResults)
    return NavigationStack { ResultView() }
        .environment(app)
        .environment(SpeechService())
}

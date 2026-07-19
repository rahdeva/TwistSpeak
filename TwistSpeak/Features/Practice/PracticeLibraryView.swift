//
//  PracticeLibraryView.swift
//  TwistSpeak
//
//  Practice tab: levels, filters, challenge modes and the library (PRD §16.1).
//

import SwiftUI

struct PracticeLibraryView: View {
    @Environment(AppState.self) private var app
    @State private var filter: Difficulty? = nil

    private let filters: [Difficulty?] = [nil, .starter, .mover, .speaker]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Practice").font(.tsTitle)

                filterRow
                challengeModeCards
                reviewCards

                HStack {
                    Text("Speaker level").font(.system(size: 16, weight: .heavy, design: .rounded))
                    Spacer()
                    Text("12 / 20").font(.system(size: 13, weight: .semibold)).foregroundStyle(TS.muted)
                }
                .padding(.top, 4)

                ForEach(SampleData.library(for: filter)) { twister in
                    LibraryCard(twister: twister, status: app.status(for: twister)) {
                        app.startPractice(twister)
                    }
                }

                lockedCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
            .padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var filterRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(filters.enumerated()), id: \.offset) { _, f in
                    let selected = f == filter
                    Button {
                        filter = f
                    } label: {
                        Text(f?.rawValue ?? "All levels")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(selected ? .white : TS.textSecondary)
                            .padding(.horizontal, 14).padding(.vertical, 8)
                            .background(selected ? TS.primary : TS.card, in: Capsule())
                            .overlay(selected ? nil : Capsule().stroke(TS.hairline, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var challengeModeCards: some View {
        HStack(spacing: 10) {
            Button {
                app.push(.accuracyChallenge(app.activeTwister))
            } label: {
                modeCard(emoji: "🎯", title: "Accuracy", subtitle: "Clear before fast",
                         gradient: TS.correctGradient, locked: false, tint: .white)
            }
            .buttonStyle(.plain)

            Button {
                app.push(.speedChallenge(app.activeTwister))
            } label: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("⚡").font(.system(size: 22))
                    HStack(spacing: 6) {
                        Text("Speed").font(.system(size: 15, weight: .heavy, design: .rounded))
                        Text("🔒").font(.system(size: 11))
                    }
                    .padding(.top, 8)
                    Text("Unlock at 90% mastery")
                        .font(.system(size: 12)).foregroundStyle(TS.muted).padding(.top, 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                .background(TS.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
            }
            .buttonStyle(.plain)
        }
    }

    private func modeCard(emoji: String, title: String, subtitle: String,
                          gradient: LinearGradient, locked: Bool, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(emoji).font(.system(size: 22))
            Text(title).font(.system(size: 15, weight: .heavy, design: .rounded))
                .foregroundStyle(tint).padding(.top, 8)
            Text(subtitle).font(.system(size: 12)).foregroundStyle(tint.opacity(0.9)).padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(gradient, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var reviewCards: some View {
        HStack(spacing: 10) {
            Button { app.push(.mistakeReview) } label: {
                smallReviewCard(emoji: "🔁", title: "Mistake Review", subtitle: "8 items")
            }.buttonStyle(.plain)
            Button { app.push(.mistakeReview) } label: {
                smallReviewCard(emoji: "🔊", title: "Trouble Sounds", subtitle: "/s/ /ʃ/ /θ/")
            }.buttonStyle(.plain)
        }
    }

    private func smallReviewCard(emoji: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 10) {
            Text(emoji).font(.system(size: 20))
            VStack(alignment: .leading, spacing: 1) {
                Text(title).font(.system(size: 14, weight: .heavy, design: .rounded))
                Text(subtitle).font(.system(size: 12)).foregroundStyle(TS.muted)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14).padding(.vertical, 13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(TS.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
    }

    private var lockedCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("🔒 LOCKED")
                    .font(.system(size: 11, weight: .heavy, design: .rounded))
                    .foregroundStyle(TS.muted)
                    .padding(.horizontal, 10).padding(.vertical, 4)
                    .background(Color(hex: 0xEDEFF4), in: Capsule())
                Spacer()
                Text("Master level").font(.system(size: 12, weight: .bold, design: .rounded)).foregroundStyle(TS.muted)
            }
            Text("Master & Legend").font(.system(size: 17, weight: .heavy, design: .rounded)).foregroundStyle(TS.muted)
            Text("Reach Speaker mastery to unlock").font(.system(size: 14)).foregroundStyle(TS.mutedLight)
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: 0xF6F7FB), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundStyle(Color(hex: 0xD5D8E4)))
        .opacity(0.85)
    }
}

private struct LibraryCard: View {
    let twister: TongueTwister
    let status: PracticeStatus
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    statusBadge
                    Spacer()
                    StarRow(filled: stars)
                }
                .padding(.bottom, 6)
                Text(twister.title).font(.system(size: 17, weight: .heavy, design: .rounded))
                Text("\"\(twister.text.replacingOccurrences(of: ".", with: ""))\"")
                    .font(.system(size: 14)).foregroundStyle(TS.textSecondary)
                    .lineLimit(1).padding(.top, 3)
                HStack(spacing: 6) {
                    TagChip(text: twister.targetSounds.joined(separator: " "))
                    if let best = bestText { TagChip(text: best) }
                }
                .padding(.top, 8)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(TS.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private var statusBadge: some View {
        let (text, fg, bg): (String, Color, Color)
        switch status {
        case .mastered: (text, fg, bg) = ("✓ MASTERED", TS.correctDeep, TS.correctTint)
        case .practicing, .completed: (text, fg, bg) = ("◐ PRACTICING", TS.primary, TS.primaryTint)
        case .notStarted: (text, fg, bg) = ("NEW", TS.muted, TS.uncertainTint)
        }
        return Text(text)
            .font(.system(size: 11, weight: .heavy, design: .rounded))
            .foregroundStyle(fg)
            .padding(.horizontal, 10).padding(.vertical, 4)
            .background(bg, in: Capsule())
    }

    private var stars: Int {
        switch status {
        case .mastered: return 3
        case .completed, .practicing: return 1
        case .notStarted: return 0
        }
    }

    private var bestText: String? {
        switch status {
        case .mastered: return "Best 88"
        case .practicing, .completed: return "Best 76"
        case .notStarted: return nil
        }
    }
}

#Preview {
    NavigationStack { PracticeLibraryView() }
        .environment(AppState())
        .environment(SpeechService())
}

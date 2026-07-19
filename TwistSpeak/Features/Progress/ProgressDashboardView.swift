//
//  ProgressDashboardView.swift
//  TwistSpeak
//
//  Simple, student-readable charts (PRD §16.1, §17.13).
//

import SwiftUI

struct ProgressDashboardView: View {
    @Environment(AppState.self) private var app

    private let week: [(String, Double, Bool)] = [
        ("M", 0.55, false), ("T", 0.75, false), ("W", 0.35, false),
        ("T", 0.65, false), ("F", 0.90, true), ("S", 0.20, false), ("S", 0.10, false)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Your progress").font(.tsTitle).padding(.bottom, 4)

                accuracyCard
                weekCard
                beforeAfterCard
                troubleSoundsCard
            }
            .padding(.horizontal, 20).padding(.top, 6).padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var accuracyCard: some View {
        TSCard(padding: 18, cornerRadius: 20) {
            HStack(spacing: 18) {
                RingGauge(progress: app.progress.averageAccuracy / 100, lineWidth: 11,
                          color: TS.correct, centerTop: "\(Int(app.progress.averageAccuracy))%",
                          centerBottom: "Accuracy")
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Average word accuracy").font(.system(size: 12, weight: .bold, design: .rounded)).foregroundStyle(TS.muted)
                        Text("↑ 7% this week").font(.system(size: 13, weight: .bold, design: .rounded)).foregroundStyle(TS.correct)
                    }
                    HStack(spacing: 14) {
                        miniStat("\(app.progress.completedIDs.count + 24)", "Completed", TS.ink)
                        miniStat("\(app.progress.masteredIDs.count + 11)", "Mastered", TS.correct)
                        miniStat(String(format: "%.1fh", app.progress.totalPracticeSeconds / 3600), "Practiced", TS.ink)
                    }
                }
            }
        }
    }

    private func miniStat(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(value).font(.system(size: 20, weight: .heavy, design: .rounded)).foregroundStyle(color)
            Text(label).font(.system(size: 11, weight: .semibold)).foregroundStyle(TS.muted)
        }
    }

    private var weekCard: some View {
        TSCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("This week").font(.system(size: 14, weight: .heavy, design: .rounded))
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(Array(week.enumerated()), id: \.offset) { _, day in
                        VStack(spacing: 6) {
                            Spacer(minLength: 0)
                            RoundedRectangle(cornerRadius: 5)
                                .fill(day.2 ? TS.primary : (day.1 > 0.5 ? Color(hex: 0xB7BEF0) : Color(hex: 0xDFE2F0)))
                                .frame(height: max(8, 96 * day.1))
                            Text(day.0).font(.system(size: 11, weight: day.2 ? .bold : .semibold))
                                .foregroundStyle(day.2 ? TS.primary : TS.muted)
                        }
                    }
                }
                .frame(height: 120)
            }
        }
    }

    private var beforeAfterCard: some View {
        TSCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Before & after — \"seashore\"").font(.system(size: 14, weight: .heavy, design: .rounded))
                HStack(spacing: 12) {
                    scoreChip("FIRST TRY", "54%", TS.errorDeep, TS.errorTint)
                    Image(systemName: "arrow.right").foregroundStyle(TS.muted)
                    scoreChip("NOW", "92%", TS.correctDeep, TS.correctTint)
                }
            }
        }
    }

    private func scoreChip(_ label: String, _ value: String, _ fg: Color, _ bg: Color) -> some View {
        VStack(spacing: 2) {
            Text(label).font(.system(size: 11, weight: .heavy, design: .rounded)).foregroundStyle(fg)
            Text(value).font(.system(size: 24, weight: .heavy, design: .rounded)).foregroundStyle(fg)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(bg, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var troubleSoundsCard: some View {
        TSCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Trouble sounds to keep practicing").font(.system(size: 14, weight: .heavy, design: .rounded))
                FlowLayout(spacing: 8, lineSpacing: 8) {
                    soundChip("/ʃ/ · 68%", TS.practiceDeep, TS.practiceTint)
                    soundChip("/θ/ · 72%", TS.practiceDeep, TS.practiceTint)
                    soundChip("/p/ · 88%", TS.correctDeep, TS.correctTint)
                }
            }
        }
    }

    private func soundChip(_ text: String, _ fg: Color, _ bg: Color) -> some View {
        Text(text).font(.system(size: 14, weight: .bold, design: .rounded)).foregroundStyle(fg)
            .padding(.horizontal, 12).padding(.vertical, 8)
            .background(bg, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    NavigationStack { ProgressDashboardView() }
        .environment(AppState()).environment(SpeechService())
}

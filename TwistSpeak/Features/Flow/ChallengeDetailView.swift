//
//  ChallengeDetailView.swift
//  TwistSpeak
//
//  Everything before you start, with one obvious primary action (PRD §17.2).
//

import SwiftUI

struct ChallengeDetailView: View {
    @Environment(AppState.self) private var app
    let twister: TongueTwister

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 8) {
                    Pill(text: "● \(twister.difficulty.rawValue)", fg: TS.primary, bg: TS.primaryTint, bordered: false)
                    Pill(text: "Target \(twister.targetSounds.joined(separator: " "))", bg: TS.surface, bordered: false)
                    Pill(text: "~\(Int(twister.normalDuration))s", bg: TS.surface, bordered: false)
                }

                Text(twister.title).font(.tsDisplay)

                TSCard(padding: 20, cornerRadius: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        SectionLabel(text: "Target sentence").font(.system(size: 12, weight: .bold))
                        Text(twister.text)
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundStyle(TS.ink2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                HStack(spacing: 10) {
                    StatTile(caption: "Best score", value: "\(app.progress.bestScores[twister.id] ?? 88)")
                    StatTile(caption: "Best time", value: "6.2s")
                    StatTile(caption: "Target", value: "\(String(format: "%.1f", twister.targetDuration))s")
                }

                TSCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Difficult words").font(.system(size: 14, weight: .heavy, design: .rounded))
                        FlowWrap(twister.difficultWords) { word in
                            Text(word)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundStyle(TS.practiceDeep)
                                .padding(.horizontal, 12).padding(.vertical, 7)
                                .background(TS.practiceTint, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }

                HStack(spacing: 8) {
                    Image(systemName: "star.fill").foregroundStyle(TS.goldPB)
                    Text("Reward: up to 3 stars + \(twister.rewardPoints) Twist Points")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: 0x7A5E00))
                }
                .padding(.horizontal, 14).padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(TS.goldTint, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(TS.goldTintBorder, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
        .background(TS.appBackground)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Start practice", systemImage: "play.fill") {
                app.push(.listen(twister))
            }
            .padding(.horizontal, 20).padding(.vertical, 12)
            .background(.ultraThinMaterial)
        }
        .navigationTitle("Challenge detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Lightweight wrapping layout for chips.
struct FlowWrap<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let content: (Data.Element) -> Content

    init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(data), id: \.self) { item in
                content(item)
            }
        }
    }
}

#Preview {
    NavigationStack { ChallengeDetailView(twister: SampleData.seashore) }
        .environment(AppState())
        .environment(SpeechService())
}

//
//  RewardsView.swift
//  TwistSpeak
//
//  Twist Points unlock cosmetics only (PRD §18).
//

import SwiftUI

struct RewardsView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Rewards").font(.tsTitle)

                HStack(spacing: 10) {
                    currencyCard(label: "⭐ Stars", value: app.progress.totalStars, gradient: TS.practiceGradient)
                    currencyCard(label: "◆ Twist Points", value: app.progress.twistPoints, gradient: TS.brandGradientReversed)
                }

                TSCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Next reward · Ocean theme").font(.system(size: 14, weight: .heavy, design: .rounded))
                            Spacer()
                            Text("\(app.progress.twistPoints) / 800").font(.system(size: 13, weight: .heavy, design: .rounded)).foregroundStyle(TS.purple)
                        }
                        TSProgressBar(value: Double(app.progress.twistPoints) / 800, height: 9)
                        Text("Twist Points unlock themes, frames & card collections — never scoring boosts.")
                            .font(.system(size: 12)).foregroundStyle(TS.muted)
                    }
                }

                SectionLabel(text: "Badges · 4 of 10")

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ForEach(SampleData.badges) { badge in
                        BadgeTile(badge: badge)
                    }
                }
            }
            .padding(.horizontal, 20).padding(.top, 6).padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationTitle("Rewards").navigationBarTitleDisplayMode(.inline)
    }

    private func currencyCard(label: String, value: Int, gradient: LinearGradient) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.system(size: 13, weight: .bold, design: .rounded)).foregroundStyle(.white.opacity(0.95))
            Text("\(value)").font(.system(size: 26, weight: .heavy, design: .rounded)).foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(gradient, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct BadgeTile: View {
    let badge: Badge

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(badge.earned ? gradient : LinearGradient(colors: [Color(hex: 0xEDEFF4), Color(hex: 0xEDEFF4)], startPoint: .top, endPoint: .bottom))
                    .aspectRatio(1, contentMode: .fit)
                Image(systemName: badge.earned ? badge.symbol : "lock.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(badge.earned ? .white : TS.muted)
            }
            Text(badge.name).font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(badge.earned ? TS.ink : TS.muted)
                .multilineTextAlignment(.center)
        }
        .opacity(badge.earned ? 1 : 0.6)
    }

    private var gradient: LinearGradient {
        switch badge.gradient {
        case .brand: return TS.brandGradient
        case .green: return TS.correctGradient
        case .orange: return TS.practiceGradient
        case .gold: return TS.goldGradient
        }
    }
}

#Preview {
    NavigationStack { RewardsView() }
        .environment(AppState()).environment(SpeechService())
}

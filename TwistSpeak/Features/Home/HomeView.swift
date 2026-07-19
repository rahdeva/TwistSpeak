//
//  HomeView.swift
//  TwistSpeak
//
//  Home tab: Daily Twist leads; shows progress and recommendations (PRD §16.1).
//

import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                statRow
                dailyTwistCard
                continuePractice
                recommendedSection
                personalBest
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
            .padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text(greeting + ",")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(TS.textSecondary)
                Text("\(app.progress.displayName) 👋")
                    .font(.system(size: 25, weight: .heavy, design: .rounded))
            }
            Spacer()
            HStack(spacing: 8) {
                currencyPill(symbol: "star.fill", tint: TS.practice, value: app.progress.totalStars)
                currencyPill(symbol: "diamond.fill", tint: TS.purple, value: app.progress.twistPoints)
            }
        }
    }

    private func currencyPill(symbol: String, tint: Color, value: Int) -> some View {
        HStack(spacing: 5) {
            Image(systemName: symbol).font(.system(size: 13)).foregroundStyle(tint)
            Text("\(value)").font(.system(size: 14, weight: .heavy, design: .rounded))
        }
        .padding(.horizontal, 11).padding(.vertical, 7)
        .background(TS.card, in: Capsule())
        .overlay(Capsule().stroke(TS.cardBorder, lineWidth: 1))
        .shadow(color: TS.ink.opacity(0.08), radius: 5, y: 3)
    }

    private var statRow: some View {
        HStack(spacing: 10) {
            TSCard(padding: 14, cornerRadius: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    SectionLabel(text: "Level", color: TS.muted).font(.system(size: 12, weight: .bold))
                    Text(app.progress.currentLevel.rawValue)
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                    TSProgressBar(value: app.progress.levelProgress)
                }
            }
            TSCard(padding: 14, cornerRadius: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    SectionLabel(text: "Streak", color: TS.muted).font(.system(size: 12, weight: .bold))
                    HStack(alignment: .firstTextBaseline, spacing: 5) {
                        Text("\(app.progress.streakCount)")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                        Text("days 🔥").font(.system(size: 13, weight: .semibold)).foregroundStyle(TS.textSecondary)
                    }
                    HStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { i in
                            Capsule().fill(i < app.progress.streakCount ? TS.practice : TS.track)
                                .frame(height: 6)
                        }
                    }
                }
            }
        }
    }

    private var dailyTwistCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionLabel(text: "Daily Twist", color: TS.purple)
                .padding(.top, 4)
            Button {
                app.activeTwister = SampleData.daily
                app.push(.dailyTwist)
            } label: {
                ZStack(alignment: .topTrailing) {
                    Circle().fill(.white.opacity(0.12)).frame(width: 150, height: 150)
                        .offset(x: 30, y: -30)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            miniTag("+30 bonus points")
                            miniTag("~2 min")
                        }
                        Text("\"\(SampleData.daily.text.replacingOccurrences(of: ".", with: ""))\"")
                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .fixedSize(horizontal: false, vertical: true)
                        HStack {
                            Text("\(SampleData.daily.difficulty.rawValue) · target \(SampleData.daily.targetSounds.joined(separator: " "))")
                                .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white.opacity(0.9))
                            Spacer()
                            HStack(spacing: 6) { Text("Start"); Image(systemName: "play.fill").font(.system(size: 11)) }
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .foregroundStyle(TS.primary)
                                .padding(.horizontal, 14).padding(.vertical, 8)
                                .background(.white, in: Capsule())
                        }
                    }
                    .padding(20)
                }
                .background(TS.brandGradient, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: TS.primary.opacity(0.5), radius: 18, y: 14)
            }
            .buttonStyle(.plain)
        }
    }

    private var continuePractice: some View {
        Button {
            app.startPractice(SampleData.peterPiper)
        } label: {
            HStack(spacing: 14) {
                IconBadge(systemName: "play.fill")
                VStack(alignment: .leading, spacing: 4) {
                    Text("CONTINUE PRACTICE")
                        .font(.system(size: 12, weight: .bold, design: .rounded)).foregroundStyle(TS.muted)
                    Text("Peter Piper picked…").font(.system(size: 16, weight: .bold, design: .rounded))
                    TSProgressBar(value: 0.4, height: 5, fill: LinearGradient(colors: [TS.primary, TS.primary], startPoint: .leading, endPoint: .trailing))
                }
                Image(systemName: "chevron.right").foregroundStyle(Color(hex: 0xC3C7D4))
            }
            .padding(16)
            .background(TS.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recommended for you").font(.system(size: 16, weight: .heavy, design: .rounded))
                Spacer()
                Button("See all") { app.selectedTab = .practice }
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(TS.primary)
            }
            .padding(.top, 8)

            Button {
                app.startPractice(SampleData.bigBlackBug)
            } label: {
                HStack(spacing: 13) {
                    Text("🐝").font(.system(size: 20))
                        .frame(width: 46, height: 46)
                        .background(TS.practiceTint, in: RoundedRectangle(cornerRadius: 13, style: .continuous))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("A big black bug…").font(.system(size: 16, weight: .bold, design: .rounded))
                        Text("Mover · target /b/ · best 76%")
                            .font(.system(size: 13)).foregroundStyle(TS.textSecondary)
                    }
                    Spacer()
                    StarRow(filled: 2)
                }
                .padding(16)
                .background(TS.card, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(TS.cardBorder, lineWidth: 1))
            }
            .buttonStyle(.plain)
        }
    }

    private var personalBest: some View {
        HStack(spacing: 13) {
            Image(systemName: "star.fill").font(.system(size: 22)).foregroundStyle(TS.goldPB)
            VStack(alignment: .leading, spacing: 2) {
                Text("RECENT PERSONAL BEST")
                    .font(.system(size: 12, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color(hex: 0xB08900))
                Text("Peter Piper — 94% accuracy")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(hex: 0x7A5E00))
            }
            Spacer()
        }
        .padding(16)
        .background(TS.goldTint, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(TS.goldTintBorder, lineWidth: 1))
    }

    private func miniTag(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal, 10).padding(.vertical, 4)
            .background(.white.opacity(0.22), in: Capsule())
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }
}

#Preview {
    NavigationStack { HomeView() }
        .environment(AppState())
        .environment(SpeechService())
}

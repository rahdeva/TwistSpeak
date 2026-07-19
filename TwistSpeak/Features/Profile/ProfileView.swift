//
//  ProfileView.swift
//  TwistSpeak
//
//  Private by default. Settings and accessibility (PRD §16.1, §22).
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppState.self) private var app

    @State private var soundEffects = true
    @State private var largerText = false
    @State private var reduceMotion = true
    @State private var showResetConfirm = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                profileHeader

                SectionLabel(text: "Practice")
                TSCard(padding: 0, cornerRadius: 16) {
                    VStack(spacing: 0) {
                        navRow("Pronunciation audio", trailing: "Human voice")
                        Divider().padding(.leading, 16)
                        toggleRow("Sound effects", isOn: $soundEffects)
                        Divider().padding(.leading, 16)
                        navRow("Interface language", trailing: "English")
                    }
                }

                SectionLabel(text: "Privacy & accessibility")
                TSCard(padding: 0, cornerRadius: 16) {
                    VStack(spacing: 0) {
                        navRow("App permissions", trailing: "Mic · Speech")
                        Divider().padding(.leading, 16)
                        navRow("Privacy settings", trailing: "")
                        Divider().padding(.leading, 16)
                        toggleRow("Larger text (Dynamic Type)", isOn: $largerText)
                        Divider().padding(.leading, 16)
                        toggleRow("Reduce Motion", isOn: $reduceMotion)
                    }
                }

                Button {
                    showResetConfirm = true
                } label: {
                    Text("Reset progress…")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(TS.errorDeep)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(TS.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color(hex: 0xF6D5D5), lineWidth: 1))
                }
                .buttonStyle(.plain)

                Text("No public profile · no ads · recordings removed after each check")
                    .font(.system(size: 12)).foregroundStyle(TS.mutedLight)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            .padding(.horizontal, 20).padding(.top, 6).padding(.bottom, 24)
        }
        .background(TS.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .confirmationDialog("Reset all progress?", isPresented: $showResetConfirm, titleVisibility: .visible) {
            Button("Reset progress", role: .destructive) {
                app.progress = UserProgress(displayName: app.progress.displayName)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This clears your stars, points, streak and history. It can't be undone.")
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 0) {
            Text(String(app.progress.displayName.prefix(1)))
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 84, height: 84)
                .background(TS.brandGradient, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: TS.primary.opacity(0.5), radius: 14, y: 12)

            Text(app.progress.displayName).font(.system(size: 22, weight: .heavy, design: .rounded)).padding(.top, 12)

            Text("\(app.progress.currentLevel.rawValue) · Level 2")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(TS.primary)
                .padding(.horizontal, 12).padding(.vertical, 5)
                .background(TS.primaryTint, in: Capsule())
                .padding(.top, 6)

            HStack(spacing: 18) {
                headerStat("⭐ \(app.progress.totalStars)", "Stars")
                headerStat("◆ \(app.progress.twistPoints)", "Points")
                headerStat("🏅 \(app.progress.badges.count)", "Badges")
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 4)
    }

    private func headerStat(_ value: String, _ label: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.system(size: 20, weight: .heavy, design: .rounded))
            Text(label).font(.system(size: 11, weight: .semibold)).foregroundStyle(TS.muted)
        }
    }

    private func navRow(_ title: String, trailing: String) -> some View {
        HStack {
            Text(title).font(.system(size: 15, weight: .semibold))
            Spacer()
            if !trailing.isEmpty {
                Text(trailing).font(.system(size: 14)).foregroundStyle(TS.muted)
            }
            Image(systemName: "chevron.right").font(.system(size: 13)).foregroundStyle(TS.muted)
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
    }

    private func toggleRow(_ title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title).font(.system(size: 15, weight: .semibold))
        }
        .tint(TS.correct)
        .padding(.horizontal, 16).padding(.vertical, 8)
    }
}

extension UserProgress {
    init(displayName: String) {
        self.init()
        self.displayName = displayName
        self.totalStars = 0
        self.twistPoints = 0
        self.streakCount = 0
        self.completedIDs = []
        self.masteredIDs = []
        self.badges = []
        self.bestScores = [:]
        self.averageAccuracy = 0
        self.totalPracticeSeconds = 0
    }
}

#Preview {
    NavigationStack { ProfileView() }
        .environment(AppState()).environment(SpeechService())
}

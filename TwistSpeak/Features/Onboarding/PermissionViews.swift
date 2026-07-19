//
//  PermissionViews.swift
//  TwistSpeak
//
//  Pre-permission education + denied recovery (PRD §17.1, §26).
//

import SwiftUI

/// Shared layout for the two permission-priming screens.
private struct PermissionScaffold<Buttons: View>: View {
    let onBack: () -> Void
    let symbol: String
    let symbolTint: Color
    let symbolBg: Color
    let title: String
    let message: String
    let reassurance: String
    @ViewBuilder var buttons: Buttons

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackLink { onBack() }
                .padding(.top, 14)

            VStack(alignment: .leading, spacing: 24) {
                IconBadge(systemName: symbol, tint: symbolTint, background: symbolBg,
                          size: 96, corner: 26)

                VStack(alignment: .leading, spacing: 14) {
                    Text(title)
                        .font(.system(size: 27, weight: .heavy, design: .rounded))
                        .fixedSize(horizontal: false, vertical: true)
                    Text(message)
                        .font(.system(size: 16))
                        .foregroundStyle(TS.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Callout(text: reassurance, systemImage: "checkmark", tint: TS.correct)
            }
            .frame(maxHeight: .infinity, alignment: .center)

            buttons
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 26)
        .screenBackground()
    }
}

struct PermissionMicView: View {
    @Environment(AppState.self) private var app
    @Environment(SpeechService.self) private var speech

    var body: some View {
        PermissionScaffold(
            onBack: { app.phase = .onboarding },
            symbol: "mic.fill", symbolTint: TS.primary, symbolBg: TS.primaryTint,
            title: "TwistSpeak uses your microphone to hear your practice",
            message: "You'll record short attempts so the app can check which words came through clearly. Nothing plays for anyone else.",
            reassurance: "Your practice recording is only used to check your attempt, then removed.")
        {
            VStack(spacing: 6) {
                PrimaryButton(title: "Allow microphone") {
                    Task {
                        _ = await speech.requestMicPermission()
                        app.phase = .permissionSpeech
                    }
                }
                GhostButton(title: "Not now") { app.phase = .permissionSpeech }
            }
        }
    }
}

struct PermissionSpeechView: View {
    @Environment(AppState.self) private var app
    @Environment(SpeechService.self) private var speech

    var body: some View {
        PermissionScaffold(
            onBack: { app.phase = .permissionMic },
            symbol: "waveform", symbolTint: TS.purple, symbolBg: TS.purpleTint,
            title: "Speech recognition helps match your words with the challenge",
            message: "It turns what you say into text so TwistSpeak can highlight the words you nailed and the ones to practice.",
            reassurance: "We check words against the target sentence — this isn't an accent or medical assessment.")
        {
            VStack(spacing: 6) {
                PrimaryButton(title: "Turn on speech recognition") {
                    Task {
                        let granted = await speech.requestSpeechPermission()
                        app.phase = granted ? .main : .permissionDenied
                    }
                }
                GhostButton(title: "See denied state") { app.phase = .permissionDenied }
            }
        }
    }
}

struct PermissionDeniedView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackLink(title: "Back to practice") { app.phase = .main }
                .padding(.top, 14)

            VStack(alignment: .leading, spacing: 22) {
                IconBadge(systemName: "mic.slash.fill", tint: TS.practice,
                          background: Color(hex: 0xFEF1E1), size: 96, corner: 26)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Microphone is switched off")
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                    Text("No problem — TwistSpeak needs the mic to hear your practice. You can turn it back on in Settings any time.")
                        .font(.system(size: 16))
                        .foregroundStyle(TS.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(alignment: .leading, spacing: 10) {
                    settingsStep(1, "Open Settings › TwistSpeak")
                    settingsStep(2, "Turn on Microphone")
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)

            PrimaryButton(title: "Open Settings") { openSettings() }
            GhostButton(title: "Return to home") { app.phase = .main }
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 26)
        .screenBackground()
    }

    private func settingsStep(_ n: Int, _ text: String) -> some View {
        HStack(spacing: 12) {
            Text("\(n)")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(TS.primary)
                .frame(width: 26, height: 26)
                .background(TS.primaryTint, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            Text(text)
                .font(.system(size: 15))
                .foregroundStyle(TS.textBody)
        }
    }

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview("Mic") {
    PermissionMicView().environment(AppState()).environment(SpeechService())
}

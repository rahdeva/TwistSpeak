//
//  DifficultWordView.swift
//  TwistSpeak
//
//  One word at a time — focused and calm (PRD §17.10).
//

import SwiftUI
import AVFoundation

struct DifficultWordView: View {
    @Environment(AppState.self) private var app
    @State private var index = 0
    @State private var synthesizer = AVSpeechSynthesizer()

    private var words: [String] {
        app.activeTwister.difficultWords.isEmpty ? ["seashells", "seashore"] : app.activeTwister.difficultWords
    }
    private var word: String { words[min(index, words.count - 1)] }

    var body: some View {
        VStack(spacing: 0) {
            header
            progressBars

            Spacer()

            VStack(spacing: 22) {
                VStack(spacing: 8) {
                    Text("Target sound \(app.activeTwister.targetSounds.first ?? "/ʃ/")")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(TS.practiceDeep)
                        .tracking(0.5)
                    Text(word)
                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                    Text(syllables(word))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(TS.muted)
                        .tracking(2)
                    Text(app.activeTwister.vocabularyNotes ?? "Keep the sound soft and clear.")
                        .font(.system(size: 15))
                        .foregroundStyle(TS.textSecondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)
                        .padding(.top, 6)
                }

                HStack(spacing: 12) {
                    SecondaryButton(title: "Listen", systemImage: "play.fill") {
                        speak(word, slow: false)
                    }
                    .frame(width: 150)
                    SecondaryButton(title: "🐢 Slow") {
                        speak(word, slow: true)
                    }
                    .frame(width: 150)
                }

                Callout(text: "Recognized: \"\(word)\" — great clarity!",
                        systemImage: "checkmark", tint: TS.correctDeep,
                        bg: TS.correctTint, border: TS.correctTintBorder, textColor: TS.correctDeep)
            }
            .padding(.horizontal, 20)

            Spacer()

            VStack(spacing: 4) {
                Button {
                    advance()
                } label: {
                    HStack(spacing: 10) {
                        Circle().fill(.white).frame(width: 12, height: 12)
                        Text("Record this word")
                    }
                    .font(.system(size: 17, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 58)
                    .background(TS.error, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: TS.error.opacity(0.55), radius: 14, y: 12)
                }
                .buttonStyle(.plain)

                Button(index < words.count - 1 ? "Next word ▸" : "Back to full challenge ▸") {
                    advance()
                }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(TS.primary)
                .frame(height: 48)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(TS.appBackground)
        .navigationTitle("Difficult word")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { synthesizer.stopSpeaking(at: .immediate) }
    }

    private var header: some View {
        HStack {
            BackLink(title: "Full challenge") { app.pop() }
            Spacer()
            Text("Word \(min(index + 1, words.count)) of \(words.count)")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(TS.muted)
        }
        .padding(.horizontal, 20).padding(.top, 8)
    }

    private var progressBars: some View {
        HStack(spacing: 6) {
            ForEach(words.indices, id: \.self) { i in
                Capsule().fill(i <= index ? TS.primary : TS.track).frame(height: 6)
            }
        }
        .padding(.horizontal, 20).padding(.top, 12)
    }

    private func advance() {
        if index < words.count - 1 {
            index += 1
        } else {
            app.pop()
        }
    }

    private func syllables(_ word: String) -> String {
        word.uppercased()
    }

    private func speak(_ text: String, slow: Bool) {
        synthesizer.stopSpeaking(at: .immediate)
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        let u = AVSpeechUtterance(string: text)
        u.voice = AVSpeechSynthesisVoice(language: "en-US")
        u.rate = slow ? AVSpeechUtteranceMinimumSpeechRate * 1.8 : AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(u)
    }
}

#Preview {
    NavigationStack { DifficultWordView() }
        .environment(AppState())
        .environment(SpeechService())
}

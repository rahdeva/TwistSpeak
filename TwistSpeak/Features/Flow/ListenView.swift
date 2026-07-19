//
//  ListenView.swift
//  TwistSpeak
//
//  Listen & Repeat: target text stays visible, normal + slow playback (PRD §17.3).
//

import SwiftUI
import AVFoundation

struct ListenView: View {
    @Environment(AppState.self) private var app
    let twister: TongueTwister

    @State private var wordByWord = false
    @State private var highlightIndex = -1
    @State private var synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack(spacing: 26) {
                    sayThisCard
                    playbackControls
                    trickyWords
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 100)
            }
        }
        .background(TS.appBackground)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "I'm ready to record", background: TS.correct) {
                stopSpeaking()
                app.push(.record)
            }
            .padding(.horizontal, 20).padding(.vertical, 12)
            .background(.ultraThinMaterial)
        }
        .navigationTitle("Listen & Repeat")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { stopSpeaking() }
    }

    private var header: some View {
        HStack {
            Text("LISTEN & REPEAT")
                .font(.system(size: 13, weight: .heavy, design: .rounded))
                .tracking(0.5)
                .foregroundStyle(TS.purple)
            Spacer()
            Button {
                wordByWord.toggle()
            } label: {
                Text("Aa word-by-word")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(TS.primary)
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(wordByWord ? TS.primaryTint : TS.card, in: Capsule())
                    .overlay(Capsule().stroke(TS.hairline, lineWidth: 1))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }

    private var sayThisCard: some View {
        TSCard(padding: 22, cornerRadius: 24) {
            VStack(alignment: .leading, spacing: 14) {
                SectionLabel(text: "Say this").font(.system(size: 12, weight: .bold))
                wrappedSentence
            }
        }
    }

    private var wrappedSentence: some View {
        FlowLayout(spacing: 4, lineSpacing: 6) {
            ForEach(Array(twister.words.enumerated()), id: \.offset) { idx, word in
                Text(word)
                    .font(.system(size: 27, weight: .semibold, design: .rounded))
                    .foregroundStyle(color(for: idx))
                    .padding(.horizontal, 4).padding(.vertical, 2)
                    .background(highlightIndex == idx ? TS.primaryTint : .clear,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
    }

    private func color(for idx: Int) -> Color {
        if highlightIndex == idx { return TS.primary }
        if wordByWord && highlightIndex >= 0 { return Color(hex: 0xB9BDCB) }
        return TS.ink2
    }

    private var playbackControls: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Play example", systemImage: "play.fill", height: 60) {
                speak(rate: AVSpeechUtteranceDefaultSpeechRate)
            }
            HStack(spacing: 12) {
                SecondaryButton(title: "Slow 0.5×", systemImage: "tortoise.fill") {
                    speak(rate: AVSpeechUtteranceMinimumSpeechRate * 1.6)
                }
                SecondaryButton(title: "Replay", systemImage: "arrow.clockwise") {
                    speak(rate: AVSpeechUtteranceDefaultSpeechRate)
                }
            }
        }
    }

    private var trickyWords: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tricky words — tap to hear")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(TS.muted)
            FlowWrap(twister.difficultWords) { word in
                Button {
                    speakWord(word)
                } label: {
                    Text("🔊 \(word)")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(TS.practiceDeep)
                        .padding(.horizontal, 14).padding(.vertical, 9)
                        .background(TS.practiceTint, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(TS.practiceTintBorder, lineWidth: 1))
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Speech synthesis (example playback)

    private func speak(rate: Float) {
        stopSpeaking()
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        let utterance = AVSpeechUtterance(string: twister.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rate
        synthesizer.speak(utterance)
        animateHighlight()
    }

    private func speakWord(_ word: String) {
        stopSpeaking()
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate * 1.8
        synthesizer.speak(utterance)
    }

    private func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        highlightIndex = -1
    }

    private func animateHighlight() {
        guard wordByWord else { return }
        let words = twister.words
        for (i, _) in words.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.42) {
                if synthesizer.isSpeaking { highlightIndex = i }
                if i == words.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) { highlightIndex = -1 }
                }
            }
        }
    }
}

/// A simple flowing (wrapping) layout.
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    var lineSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, lineHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth {
                x = 0
                y += lineHeight + lineSpacing
                lineHeight = 0
            }
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        return CGSize(width: maxWidth == .infinity ? x : maxWidth, height: y + lineHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, lineHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += lineHeight + lineSpacing
                lineHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}

#Preview {
    NavigationStack { ListenView(twister: SampleData.seashore) }
        .environment(AppState())
        .environment(SpeechService())
}

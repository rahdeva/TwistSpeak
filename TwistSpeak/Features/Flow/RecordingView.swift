//
//  RecordingView.swift
//  TwistSpeak
//
//  The key screen: an unambiguous listening state and a big record button
//  (PRD §17.4). Uses the live SpeechService.
//

import SwiftUI

struct RecordingView: View {
    @Environment(AppState.self) private var app
    @Environment(SpeechService.self) private var speech
    @Environment(\.dismiss) private var dismiss

    private var listening: Bool { speech.state == .listening }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            TSCard(padding: 18, cornerRadius: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    SectionLabel(text: "Target").font(.system(size: 12, weight: .bold))
                    Text(app.activeTwister.text)
                        .font(.system(size: 19, weight: .semibold, design: .rounded))
                        .foregroundStyle(TS.ink2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 16)

            Spacer()

            VStack(spacing: 22) {
                Text(timeString)
                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(listening ? TS.errorDeep : TS.ink2)

                waveform

                Text(listening ? guideText : "Tap the mic when you're ready")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(listening ? TS.correct : TS.muted)
                    .frame(minHeight: 20)

                recordButton

                Text(listening ? "Tap to stop" : "Tap to start")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(listening ? TS.errorDeep : TS.ink2)
            }

            Spacer()

            HStack(spacing: 8) {
                Image(systemName: "lock.fill").font(.system(size: 12)).foregroundStyle(TS.muted)
                Text("Recording is only used to check this attempt · max \(app.activeTwister.difficulty.maxRecordingSeconds)s")
                    .font(.system(size: 12, weight: .semibold)).foregroundStyle(TS.textSecondary)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal, 22)
            .padding(.bottom, 20)
        }
        .background((listening ? Color(hex: 0xFFF5F5) : TS.appBackground).animation(.easeInOut(duration: 0.4)))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onDisappear {
            if speech.state == .listening { speech.cancel() }
        }
    }

    private var topBar: some View {
        HStack {
            Button("Cancel") {
                speech.cancel()
                app.pop()
            }
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(TS.muted)

            Spacer()

            HStack(spacing: 6) {
                if listening {
                    Circle().fill(TS.error).frame(width: 8, height: 8)
                }
                Text(listening ? "Listening" : "Ready")
                    .font(.system(size: 13, weight: .heavy, design: .rounded))
            }
            .foregroundStyle(listening ? TS.errorDeep : TS.primary)
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(listening ? TS.errorTint : TS.primaryTint, in: Capsule())
        }
        .padding(.horizontal, 22)
        .padding(.top, 8)
    }

    private var waveform: some View {
        HStack(alignment: .bottom, spacing: 4) {
            ForEach(0..<18, id: \.self) { i in
                Capsule()
                    .fill(listening ? TS.error : Color(hex: 0xC9CFF7))
                    .frame(width: 5, height: barHeight(i))
                    .animation(.easeInOut(duration: 0.25), value: speech.level)
            }
        }
        .frame(height: 56)
    }

    private func barHeight(_ i: Int) -> CGFloat {
        guard listening else { return 12 }
        let base = 14.0
        let variation = sin(Double(i) * 0.9) * 0.5 + 0.5
        return base + CGFloat(speech.level * 42 * variation) + CGFloat(variation * 6)
    }

    private var recordButton: some View {
        ZStack {
            if listening {
                Circle().fill(TS.error.opacity(0.35))
                    .frame(width: 132, height: 132)
                    .scaleEffect(listening ? 1.4 : 1)
                    .opacity(listening ? 0 : 0.5)
                    .animation(.easeOut(duration: 1.8).repeatForever(autoreverses: false), value: listening)
            }
            Button {
                toggleRecording()
            } label: {
                ZStack {
                    Circle().fill(TS.error)
                        .frame(width: 104, height: 104)
                        .overlay(Circle().stroke(.white, lineWidth: 6))
                        .shadow(color: TS.error.opacity(0.55), radius: 16, y: 14)
                    if listening {
                        RoundedRectangle(cornerRadius: 8).fill(.white).frame(width: 34, height: 34)
                    } else {
                        Image(systemName: "mic.fill").font(.system(size: 36)).foregroundStyle(.white)
                    }
                }
            }
            .buttonStyle(.plain)
        }
        .frame(height: 132)
    }

    private var timeString: String {
        let total = Int(speech.elapsed)
        return String(format: "0:%02d", total)
    }

    private var guideText: String {
        speech.level > 0.08 ? "Good volume — keep going" : "Speak a little louder"
    }

    private func toggleRecording() {
        if listening {
            let max = Double(app.activeTwister.difficulty.maxRecordingSeconds)
            Task {
                let result = await speech.stop()
                app.finishAttempt(transcript: result.transcript, duration: min(result.duration, max), status: result.status)
                app.push(.processing)
            }
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            speech.start(maxDuration: Double(app.activeTwister.difficulty.maxRecordingSeconds)) {
                // Auto-stop at max duration.
                Task {
                    let result = await speech.stop()
                    app.finishAttempt(transcript: result.transcript, duration: result.duration, status: result.status)
                    app.push(.processing)
                }
            }
        }
    }
}

#Preview {
    NavigationStack { RecordingView() }
        .environment(AppState())
        .environment(SpeechService())
}

//
//  OnboardingView.swift
//  TwistSpeak
//
//  Four steps: listen, record, improve, earn (PRD §17.1).
//

import SwiftUI

private struct OnboardStep: Identifiable {
    let id = Int()
    let symbol: String
    let title: String
    let body: String
    let tint: Color
    let tintBg: Color
}

struct OnboardingView: View {
    @Environment(AppState.self) private var app
    @State private var index = 0

    private let steps: [OnboardStep] = [
        .init(symbol: "play.fill", title: "Listen to the example",
              body: "Hear each tongue twister spoken clearly. Slow it down whenever you need to.",
              tint: TS.primary, tintBg: TS.primaryTint),
        .init(symbol: "mic.fill", title: "Record your voice",
              body: "Say the whole sentence and let TwistSpeak listen to your attempt.",
              tint: TS.purple, tintBg: TS.purpleTint),
        .init(symbol: "checkmark.seal.fill", title: "See words to improve",
              body: "We highlight the words you nailed and the ones worth another try.",
              tint: TS.correct, tintBg: TS.correctTint),
        .init(symbol: "star.fill", title: "Earn rewards & build a streak",
              body: "Collect stars and Twist Points, and keep your daily streak alive.",
              tint: TS.practice, tintBg: TS.practiceTint)
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button("Skip") { app.phase = .permissionMic }
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(TS.muted)
                    .padding(6)
            }
            .padding(.horizontal, 22)
            .padding(.top, 8)

            Spacer()

            let step = steps[index]
            VStack(spacing: 26) {
                ZStack {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(LinearGradient(colors: [TS.primaryTint, TS.purpleTint],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 210, height: 210)
                    Circle().stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .foregroundStyle(TS.primary.opacity(0.35))
                        .frame(width: 120, height: 120)
                    Circle().fill(.white)
                        .frame(width: 78, height: 78)
                        .shadow(color: TS.primary.opacity(0.4), radius: 12, y: 8)
                        .overlay(Image(systemName: step.symbol)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(step.tint))
                }
                .id(index)
                .transition(.scale.combined(with: .opacity))

                VStack(spacing: 10) {
                    Text(step.title)
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .multilineTextAlignment(.center)
                    Text(step.body)
                        .font(.system(size: 16))
                        .foregroundStyle(TS.textSecondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                }
            }
            .animation(.spring(duration: 0.35), value: index)

            Spacer()

            // Page dots
            HStack(spacing: 8) {
                ForEach(steps.indices, id: \.self) { i in
                    Capsule()
                        .fill(i == index ? TS.primary : Color(hex: 0xD5D8E6))
                        .frame(width: i == index ? 22 : 8, height: 8)
                }
            }
            .padding(.vertical, 20)

            PrimaryButton(title: index == steps.count - 1 ? "Continue" : "Next") {
                if index == steps.count - 1 {
                    app.phase = .permissionMic
                } else {
                    index += 1
                }
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 26)
        }
        .screenBackground()
    }
}

#Preview {
    OnboardingView().environment(AppState())
}

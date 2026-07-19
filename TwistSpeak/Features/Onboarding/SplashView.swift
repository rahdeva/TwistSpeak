//
//  SplashView.swift
//  TwistSpeak
//

import SwiftUI

struct SplashView: View {
    @Environment(AppState.self) private var app
    @State private var animate = false

    var body: some View {
        ZStack {
            TS.splashGradient.ignoresSafeArea()

            VStack(spacing: 26) {
                Spacer()

                // Animated sound bars
                HStack(alignment: .bottom, spacing: 6) {
                    ForEach(Array(barHeights.enumerated()), id: \.offset) { idx, h in
                        Capsule()
                            .fill(Color.white.opacity(idx == 0 || idx == 5 ? 0.6 : 1))
                            .frame(width: 7, height: animate ? h : h * 0.4)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(idx) * 0.12),
                                value: animate)
                    }
                }
                .frame(height: 74)

                VStack(spacing: 8) {
                    Text("TwistSpeak")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Twist Your Words. Train Your Voice.")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }

                Spacer()

                Text("LISTEN · TWIST · SPEAK · MASTER")
                    .font(.system(size: 13, weight: .semibold))
                    .tracking(3)
                    .foregroundStyle(.white.opacity(0.7))

                Button {
                    app.phase = .onboarding
                } label: {
                    Text("Get started")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(.white.opacity(0.16), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(.white.opacity(0.35), lineWidth: 1))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
            .padding(.vertical, 40)
        }
        .onAppear { animate = true }
    }

    private let barHeights: [CGFloat] = [26, 52, 70, 40, 60, 22]
}

#Preview {
    SplashView().environment(AppState())
}

//
//  ProcessingView.swift
//  TwistSpeak
//
//  Calm "checking your words" — never feels like failure (PRD §17.5).
//

import SwiftUI

struct ProcessingView: View {
    @Environment(AppState.self) private var app
    @State private var spin = false
    @State private var animateBars = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            ZStack {
                Circle().stroke(TS.track, lineWidth: 5)
                Circle()
                    .trim(from: 0, to: 0.35)
                    .stroke(TS.brandGradient, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(spin ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: spin)
                HStack(spacing: 3) {
                    ForEach(0..<3, id: \.self) { i in
                        Capsule()
                            .fill(i == 1 ? TS.purple : TS.primary)
                            .frame(width: 5, height: animateBars ? [16, 30, 20][i] : 8)
                            .animation(.easeInOut(duration: 0.9).repeatForever().delay(Double(i) * 0.15), value: animateBars)
                    }
                }
            }
            .frame(width: 120, height: 120)

            VStack(spacing: 8) {
                Text("Checking your words…")
                    .font(.system(size: 23, weight: .heavy, design: .rounded))
                Text("Matching what you said with the challenge")
                    .font(.system(size: 15)).foregroundStyle(TS.textSecondary)
            }

            Spacer()

            Button("Cancel") { app.pop() }
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(TS.textSecondary)
                .padding(.horizontal, 24).frame(height: 48)
                .background(TS.card, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(TS.hairline, lineWidth: 1))
                .buttonStyle(.plain)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
        .background(TS.appBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            spin = true
            animateBars = true
            // Brief calm delay, then advance to result.
            try? await Task.sleep(for: .milliseconds(1600))
            // Replace processing with result in the active stack.
            switch app.selectedTab {
            case .home:
                if !app.homePath.isEmpty { app.homePath.removeLast() }
                app.homePath.append(.result)
            default:
                if !app.practicePath.isEmpty { app.practicePath.removeLast() }
                app.practicePath.append(.result)
            }
        }
    }
}

#Preview {
    NavigationStack { ProcessingView() }
        .environment(AppState())
        .environment(SpeechService())
}

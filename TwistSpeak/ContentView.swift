//
//  ContentView.swift
//  TwistSpeak
//
//  Created by rahdeva on 19/07/26.
//

import SwiftUI

/// Root router — switches between onboarding phases and the main tab app.
struct RootView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        ZStack {
            switch app.phase {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .permissionMic:
                PermissionMicView()
            case .permissionSpeech:
                PermissionSpeechView()
            case .permissionDenied:
                PermissionDeniedView()
            case .main:
                MainTabView()
            }
        }
        .animation(.easeInOut(duration: 0.35), value: app.phase)
    }
}

#Preview {
    RootView()
        .environment(AppState())
        .environment(SpeechService())
}

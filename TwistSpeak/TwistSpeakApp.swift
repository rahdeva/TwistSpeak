//
//  TwistSpeakApp.swift
//  TwistSpeak
//
//  Created by rahdeva on 19/07/26.
//

import SwiftUI

@main
struct TwistSpeakApp: App {
    @State private var appState = AppState()
    @State private var speech = SpeechService()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
                .environment(speech)
                .tint(TS.primary)
        }
    }
}

//
//  MainTabView.swift
//  TwistSpeak
//
//  Tab bar: Home · Practice · Progress · Profile, each with its own stack.
//

import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var app

    var body: some View {
        @Bindable var app = app
        TabView(selection: $app.selectedTab) {
            Tab("Home", systemImage: "house.fill", value: AppTab.home) {
                NavigationStack(path: $app.homePath) {
                    HomeView().withFlowDestinations()
                }
            }
            Tab("Practice", systemImage: "square.stack.3d.up.fill", value: AppTab.practice) {
                NavigationStack(path: $app.practicePath) {
                    PracticeLibraryView().withFlowDestinations()
                }
            }
            Tab("Progress", systemImage: "chart.bar.fill", value: AppTab.progress) {
                NavigationStack {
                    ProgressDashboardView()
                }
            }
            Tab("Profile", systemImage: "person.fill", value: AppTab.profile) {
                NavigationStack {
                    ProfileView()
                }
            }
        }
        .tint(TS.primary)
    }
}

/// Attaches the shared practice-flow navigation destinations to a stack root.
private struct FlowDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content.navigationDestination(for: Route.self) { route in
            switch route {
            case .challenge(let t):        ChallengeDetailView(twister: t)
            case .listen(let t):           ListenView(twister: t)
            case .record:                  RecordingView()
            case .processing:              ProcessingView()
            case .result:                  ResultView()
            case .difficultWord:           DifficultWordView()
            case .dailyTwist:              DailyTwistView()
            case .accuracyChallenge(let t): AccuracyChallengeView(twister: t)
            case .speedChallenge(let t):   SpeedChallengeView(twister: t)
            case .mistakeReview:           MistakeReviewView()
            case .rewards:                 RewardsView()
            }
        }
    }
}

extension View {
    func withFlowDestinations() -> some View { modifier(FlowDestinations()) }
}

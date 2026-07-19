//
//  AppState.swift
//  TwistSpeak
//
//  App-wide observable state: onboarding phase, tab selection, navigation
//  paths, active practice session and the user's progress.
//

import SwiftUI
import Observation

/// Top-level app phase before the main tab experience.
enum AppPhase {
    case splash
    case onboarding
    case permissionMic
    case permissionSpeech
    case permissionDenied
    case main
}

enum AppTab: Hashable {
    case home, practice, progress, profile
}

/// Destinations reachable inside a tab's navigation stack.
enum Route: Hashable {
    case challenge(TongueTwister)
    case listen(TongueTwister)
    case record
    case processing
    case result
    case difficultWord
    case dailyTwist
    case accuracyChallenge(TongueTwister)
    case speedChallenge(TongueTwister)
    case mistakeReview
    case rewards
}

/// Which result variant to render — mirrors the prototype's variant chips so
/// error/low-confidence outcomes can be represented from real recognition.
enum ResultVariant {
    case strong, partial, best, perfect, lowConfidence, noSpeech, speedInvalid
}

@Observable
final class AppState {
    var phase: AppPhase = .splash

    var selectedTab: AppTab = .home
    var homePath: [Route] = []
    var practicePath: [Route] = []

    // Active practice session
    var activeTwister: TongueTwister = SampleData.seashore
    var lastAttempt: PracticeAttempt?
    var lastVariant: ResultVariant = .strong
    var isFirstTry: Bool = true

    // User progress
    var progress = UserProgress()

    init() { applyQAEnvironmentIfNeeded() }

    /// QA hook: jump straight to a screen via env vars for screenshot testing.
    /// Has no effect in normal launches.
    private func applyQAEnvironmentIfNeeded() {
        let env = ProcessInfo.processInfo.environment
        guard env["TS_PHASE"] == "main" else { return }
        phase = .main
        switch env["TS_TAB"] {
        case "practice": selectedTab = .practice
        case "progress": selectedTab = .progress
        case "profile": selectedTab = .profile
        default: selectedTab = .home
        }
        if let route = env["TS_ROUTE"] {
            if route == "result" {
                let outcome = WordComparison.compare(
                    target: activeTwister.text,
                    recognized: "she sells seashell by the seashore")
                lastVariant = .strong
                lastAttempt = PracticeAttempt(
                    tongueTwisterID: activeTwister.id,
                    transcription: "she sells seashell by the seashore",
                    wordAccuracy: 92, completion: 100, duration: 6.8, wordsPerMinute: 53,
                    overallScore: 88, starsEarned: 2, pointsEarned: 45, isPersonalBest: false,
                    recognitionStatus: .success, wordResults: outcome.wordResults)
            }
            let mapped: Route?
            switch route {
            case "challenge": mapped = .challenge(activeTwister)
            case "listen": mapped = .listen(activeTwister)
            case "difficult": mapped = .difficultWord
            case "daily": mapped = .dailyTwist
            case "accuracy": mapped = .accuracyChallenge(activeTwister)
            case "speed": mapped = .speedChallenge(activeTwister)
            case "mistakes": mapped = .mistakeReview
            case "rewards": mapped = .rewards
            case "result": mapped = .result
            default: mapped = nil
            }
            if let mapped {
                if selectedTab == .practice { practicePath = [mapped] }
                else { homePath = [mapped] }
            }
        }
    }

    // MARK: Navigation helpers

    /// Push a route onto whichever tab is active.
    func push(_ route: Route) {
        switch selectedTab {
        case .home: homePath.append(route)
        default: practicePath.append(route)
        }
    }

    func pop() {
        switch selectedTab {
        case .home: if !homePath.isEmpty { homePath.removeLast() }
        default: if !practicePath.isEmpty { practicePath.removeLast() }
        }
    }

    func resetActiveFlow() {
        switch selectedTab {
        case .home: homePath.removeAll()
        default: practicePath.removeAll()
        }
    }

    /// Start a practice session for a given twister and open its detail.
    func startPractice(_ twister: TongueTwister) {
        activeTwister = twister
        isFirstTry = true
        push(.challenge(twister))
    }

    // MARK: Result construction

    /// Turn a recognition outcome into a stored attempt + result variant.
    func finishAttempt(transcript: String,
                       duration: Double,
                       status: RecognitionStatus) {
        let twister = activeTwister

        // Non-success recognition → supportive, no-penalty variants.
        switch status {
        case .noSpeech:
            lastVariant = .noSpeech
            lastAttempt = PracticeAttempt(
                tongueTwisterID: twister.id, transcription: "",
                wordAccuracy: 0, completion: 0, duration: duration, wordsPerMinute: 0,
                overallScore: 0, starsEarned: 0, pointsEarned: 0, isPersonalBest: false,
                recognitionStatus: .noSpeech, wordResults: [])
            return
        case .unavailable, .interrupted:
            lastVariant = .lowConfidence
            let outcome = WordComparison.compare(target: twister.text, recognized: transcript, lowConfidence: true)
            lastAttempt = PracticeAttempt(
                tongueTwisterID: twister.id, transcription: transcript,
                wordAccuracy: 0, completion: 0, duration: duration, wordsPerMinute: 0,
                overallScore: 0, starsEarned: 0, pointsEarned: 0, isPersonalBest: false,
                recognitionStatus: status, wordResults: outcome.wordResults)
            return
        case .lowConfidence:
            lastVariant = .lowConfidence
            let outcome = WordComparison.compare(target: twister.text, recognized: transcript, lowConfidence: true)
            lastAttempt = PracticeAttempt(
                tongueTwisterID: twister.id, transcription: transcript,
                wordAccuracy: 0, completion: 0, duration: duration, wordsPerMinute: 0,
                overallScore: 0, starsEarned: 0, pointsEarned: 0, isPersonalBest: false,
                recognitionStatus: .lowConfidence, wordResults: outcome.wordResults)
            return
        case .success:
            break
        }

        let outcome = WordComparison.compare(target: twister.text, recognized: transcript)
        let wpm = Scoring.wordsPerMinute(wordCount: twister.words.count, duration: duration)
        let previousBest = progress.bestScores[twister.id]
        let score = Scoring.score(
            accuracy: outcome.wordAccuracy,
            completion: outcome.completion,
            duration: duration,
            targetDuration: twister.targetDuration,
            previousBest: previousBest,
            isFirstTry: isFirstTry)

        let isPB = previousBest.map { score.overall > $0 } ?? true

        // Pick a display variant from the numbers.
        if outcome.wordAccuracy < Scoring.speedAccuracyThreshold && duration < twister.targetDuration {
            lastVariant = .speedInvalid
        } else if score.overall >= 100 {
            lastVariant = .perfect
        } else if isPB && score.overall >= 90 {
            lastVariant = .best
        } else if score.overall >= 80 {
            lastVariant = .strong
        } else {
            lastVariant = .partial
        }

        let attempt = PracticeAttempt(
            tongueTwisterID: twister.id, transcription: transcript,
            wordAccuracy: outcome.wordAccuracy, completion: outcome.completion,
            duration: duration, wordsPerMinute: wpm, overallScore: score.overall,
            starsEarned: score.stars, pointsEarned: score.points, isPersonalBest: isPB,
            recognitionStatus: .success, wordResults: outcome.wordResults)
        lastAttempt = attempt

        // Persist lightweight progress.
        progress.bestScores[twister.id] = max(previousBest ?? 0, score.overall)
        progress.twistPoints += score.points
        progress.totalStars += score.stars
        progress.completedIDs.insert(twister.id)
        if outcome.wordAccuracy >= 90 && outcome.completion >= 95 {
            progress.masteredIDs.insert(twister.id)
        }
        progress.totalPracticeSeconds += duration
        isFirstTry = false
    }

    func status(for twister: TongueTwister) -> PracticeStatus {
        if progress.masteredIDs.contains(twister.id) { return .mastered }
        if progress.completedIDs.contains(twister.id) { return .completed }
        if progress.bestScores[twister.id] != nil { return .practicing }
        return .notStarted
    }
}

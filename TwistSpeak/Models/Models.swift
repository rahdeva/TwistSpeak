//
//  Models.swift
//  TwistSpeak
//
//  Core data models per the PRD (§23.4).
//

import SwiftUI

// MARK: - Difficulty levels

enum Difficulty: String, CaseIterable, Codable, Identifiable {
    case starter = "Starter"
    case mover = "Mover"
    case speaker = "Speaker"
    case master = "Master"
    case legend = "Legend"

    var id: String { rawValue }

    /// Max recording duration in seconds (PRD §17.4).
    var maxRecordingSeconds: Int {
        switch self {
        case .starter: return 15
        case .mover: return 25
        case .speaker: return 40
        case .master, .legend: return 45
        }
    }

    var isLockedInMVP: Bool { self == .master || self == .legend }
}

// MARK: - Practice status

enum PracticeStatus: String, Codable {
    case notStarted = "Not started"
    case practicing = "Practicing"
    case completed = "Completed"
    case mastered = "Mastered"
}

// MARK: - Word feedback status (comparison result)

enum WordStatus: String, Codable {
    case correct     // recognized & matches target
    case practice    // recognized but flagged (uncertain match / needs work)
    case missing     // target word not recognized
    case additional  // extra word the user said
    case uncertain   // low confidence, not counted

    var color: Color {
        switch self {
        case .correct: return TS.correctDeep
        case .practice: return TS.practiceDeep
        case .missing: return TS.errorDeep
        case .additional: return TS.textSecondary
        case .uncertain: return TS.muted
        }
    }

    var tint: Color {
        switch self {
        case .correct: return TS.correctTint
        case .practice: return TS.practiceTint
        case .missing: return TS.errorTint
        case .additional: return TS.uncertainTint
        case .uncertain: return TS.uncertainTint
        }
    }

    var glyph: String {
        switch self {
        case .correct: return "✓"
        case .practice: return "~"
        case .missing: return "×"
        case .additional: return "+"
        case .uncertain: return "?"
        }
    }
}

/// A single target word plus how it was recognized.
struct WordResult: Identifiable, Codable {
    let id = UUID()
    let word: String
    let status: WordStatus

    private enum CodingKeys: String, CodingKey { case word, status }
}

// MARK: - Tongue twister content

struct TongueTwister: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let text: String
    let difficulty: Difficulty
    let targetSounds: [String]
    let normalDuration: Double
    let targetDuration: Double
    let rewardPoints: Int
    let difficultWords: [String]
    let vocabularyNotes: String?
    let isDailyEligible: Bool

    static func == (lhs: TongueTwister, rhs: TongueTwister) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    /// Whitespace-tokenised target words (display form, keeps case).
    var words: [String] {
        text.replacingOccurrences(of: ".", with: "")
            .split(separator: " ")
            .map(String.init)
    }
}

// MARK: - Practice attempt

struct PracticeAttempt: Identifiable, Codable {
    let id: UUID
    let tongueTwisterID: String
    let date: Date
    let transcription: String
    let wordAccuracy: Double     // 0...100
    let completion: Double       // 0...100
    let duration: Double         // seconds
    let wordsPerMinute: Int
    let overallScore: Int        // 0...100
    let starsEarned: Int
    let pointsEarned: Int
    let isPersonalBest: Bool
    let recognitionStatus: RecognitionStatus
    let wordResults: [WordResult]

    init(id: UUID = UUID(), tongueTwisterID: String, date: Date = .now,
         transcription: String, wordAccuracy: Double, completion: Double,
         duration: Double, wordsPerMinute: Int, overallScore: Int,
         starsEarned: Int, pointsEarned: Int, isPersonalBest: Bool,
         recognitionStatus: RecognitionStatus, wordResults: [WordResult]) {
        self.id = id
        self.tongueTwisterID = tongueTwisterID
        self.date = date
        self.transcription = transcription
        self.wordAccuracy = wordAccuracy
        self.completion = completion
        self.duration = duration
        self.wordsPerMinute = wordsPerMinute
        self.overallScore = overallScore
        self.starsEarned = starsEarned
        self.pointsEarned = pointsEarned
        self.isPersonalBest = isPersonalBest
        self.recognitionStatus = recognitionStatus
        self.wordResults = wordResults
    }
}

enum RecognitionStatus: String, Codable {
    case success
    case lowConfidence
    case noSpeech
    case unavailable
    case interrupted
}

// MARK: - User progress

struct UserProgress: Codable {
    var displayName: String = "Naya"
    var currentLevel: Difficulty = .mover
    var levelProgress: Double = 0.64
    var totalStars: Int = 128
    var twistPoints: Int = 640
    var streakCount: Int = 5
    var completedIDs: Set<String> = ["seashore-sprint", "peters-pickle-pack"]
    var masteredIDs: Set<String> = ["seashore-sprint"]
    var badges: Set<String> = ["First Twist", "Clear Speaker", "5-Day Streak", "Perfect Accuracy"]
    var totalPracticeSeconds: Double = 3600 * 3.2
    var averageAccuracy: Double = 85
    var bestScores: [String: Int] = ["seashore-sprint": 88, "peters-pickle-pack": 76]
}

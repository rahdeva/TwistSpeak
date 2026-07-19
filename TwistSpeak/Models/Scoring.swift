//
//  Scoring.swift
//  TwistSpeak
//
//  Scoring model (PRD §19). Clear speech is weighted above speed.
//

import Foundation

struct ScoreResult {
    let overall: Int          // 0...100
    let stars: Int            // 0...4 (4 == perfect star)
    let points: Int
    let speedCounted: Bool
}

enum Scoring {

    static let accuracyWeight = 0.50
    static let completionWeight = 0.20
    static let speedWeight = 0.15
    static let consistencyWeight = 0.10
    static let firstTryWeight = 0.05

    /// Speed only counts above these thresholds (PRD §17.9 / §19.3).
    static let speedAccuracyThreshold = 85.0
    static let speedCompletionThreshold = 90.0

    static func score(accuracy: Double,
                      completion: Double,
                      duration: Double,
                      targetDuration: Double,
                      previousBest: Int?,
                      isFirstTry: Bool) -> ScoreResult {

        // Speed score: 100 when at or faster than target, decaying as it runs over.
        let rawSpeed = targetDuration <= 0 ? 0 : min(1.0, targetDuration / max(duration, 0.1)) * 100
        let speedCounts = accuracy >= speedAccuracyThreshold && completion >= speedCompletionThreshold
        let speedScore = speedCounts ? rawSpeed : 0

        // Consistency: reward matching or beating a previous best.
        let consistency: Double
        if let prev = previousBest {
            consistency = accuracy >= Double(prev) ? 100 : max(0, 100 - Double(prev) + accuracy)
        } else {
            consistency = 80
        }

        let firstTry = isFirstTry ? 100.0 : 0.0

        let overall = accuracy * accuracyWeight
            + completion * completionWeight
            + speedScore * speedWeight
            + consistency * consistencyWeight
            + firstTry * firstTryWeight

        let clamped = Int(max(0, min(100, overall.rounded())))

        return ScoreResult(
            overall: clamped,
            stars: stars(accuracy: accuracy, completion: completion, speedCounts: speedCounts, duration: duration, targetDuration: targetDuration),
            points: points(overall: clamped, isPersonalBest: previousBest.map { clamped > $0 } ?? true),
            speedCounted: speedCounts
        )
    }

    private static func stars(accuracy: Double, completion: Double, speedCounts: Bool,
                              duration: Double, targetDuration: Double) -> Int {
        guard completion >= 60 else { return 0 }
        // Perfect star: full completion and near-perfect accuracy.
        if completion >= 100 && accuracy >= 98 { return 4 }
        if accuracy >= 90 && completion >= 95 && speedCounts && duration <= targetDuration { return 3 }
        if accuracy >= 80 && completion >= 90 { return 2 }
        return 1
    }

    private static func points(overall: Int, isPersonalBest: Bool) -> Int {
        var pts = 15 + overall / 5
        if isPersonalBest { pts += 15 }
        return pts
    }

    static func wordsPerMinute(wordCount: Int, duration: Double) -> Int {
        guard duration > 0 else { return 0 }
        return Int((Double(wordCount) / duration * 60).rounded())
    }
}

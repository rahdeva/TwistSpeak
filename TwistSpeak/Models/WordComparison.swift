//
//  WordComparison.swift
//  TwistSpeak
//
//  Text comparison engine (PRD §17.6). Normalises + aligns the recognized
//  transcript against the target sentence, classifying each target word.
//

import Foundation

struct ComparisonOutcome {
    let wordResults: [WordResult]   // one per target word, in target order
    let additionalWords: [String]   // extra words the user said
    let wordAccuracy: Double        // 0...100 — correct / total target words
    let completion: Double          // 0...100 — recognized target words / total
}

enum WordComparison {

    /// Normalise a string into comparable word tokens (PRD processing rules).
    static func tokenize(_ text: String) -> [String] {
        let lowered = text.lowercased()
        let allowed = CharacterSet.alphanumerics.union(.whitespaces).union(CharacterSet(charactersIn: "'"))
        let cleaned = String(lowered.unicodeScalars.map { allowed.contains($0) ? Character($0) : " " })
            .replacingOccurrences(of: "'", with: "")      // normalise apostrophes away
        return cleaned.split(whereSeparator: { $0 == " " }).map(String.init)
    }

    /// Compare recognized speech with target text using LCS alignment so word
    /// order is preserved and repeats are handled correctly.
    static func compare(target: String, recognized: String, lowConfidence: Bool = false) -> ComparisonOutcome {
        let targetDisplay = target
            .replacingOccurrences(of: ".", with: "")
            .split(separator: " ").map(String.init)
        let targetTokens = targetDisplay.map { tokenize($0).first ?? $0.lowercased() }
        let recTokens = tokenize(recognized)

        // If nothing came through, everything is missing (or uncertain when low conf).
        guard !recTokens.isEmpty else {
            let results = targetDisplay.map {
                WordResult(word: $0, status: lowConfidence ? .uncertain : .missing)
            }
            return ComparisonOutcome(wordResults: results, additionalWords: [],
                                     wordAccuracy: 0, completion: 0)
        }

        // LCS table between target and recognized token streams.
        let n = targetTokens.count, m = recTokens.count
        var dp = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
        for i in stride(from: n - 1, through: 0, by: -1) {
            for j in stride(from: m - 1, through: 0, by: -1) {
                if targetTokens[i] == recTokens[j] {
                    dp[i][j] = dp[i + 1][j + 1] + 1
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j + 1])
                }
            }
        }

        // Walk the alignment.
        var matchedTarget = Array(repeating: false, count: n)
        var usedRecognized = Array(repeating: false, count: m)
        var i = 0, j = 0
        while i < n && j < m {
            if targetTokens[i] == recTokens[j] {
                matchedTarget[i] = true
                usedRecognized[j] = true
                i += 1; j += 1
            } else if dp[i + 1][j] >= dp[i][j + 1] {
                i += 1
            } else {
                j += 1
            }
        }

        // Extra words the user said that were never matched.
        let additional = recTokens.enumerated()
            .filter { !usedRecognized[$0.offset] }
            .map { $0.element }

        // Classify each target word.
        var results: [WordResult] = []
        var correctCount = 0
        var recognizedCount = 0
        for idx in targetDisplay.indices {
            let status: WordStatus
            if matchedTarget[idx] {
                recognizedCount += 1
                if lowConfidence {
                    status = .uncertain
                } else {
                    correctCount += 1
                    status = .correct
                }
            } else {
                // Missing target — but if there's leftover recognized noise nearby,
                // treat it as a practice (substituted) word rather than fully missing.
                status = lowConfidence ? .uncertain : (additional.isEmpty ? .missing : .practice)
            }
            results.append(WordResult(word: targetDisplay[idx], status: status))
        }

        let total = max(1, targetDisplay.count)
        let accuracy = Double(correctCount) / Double(total) * 100
        let completion = Double(recognizedCount) / Double(total) * 100

        return ComparisonOutcome(
            wordResults: results,
            additionalWords: additional,
            wordAccuracy: accuracy.rounded(),
            completion: completion.rounded()
        )
    }
}

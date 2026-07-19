//
//  SampleData.swift
//  TwistSpeak
//
//  Seed content for the MVP library (Starter / Mover / Speaker).
//

import Foundation

enum SampleData {

    static let seashore = TongueTwister(
        id: "seashore-sprint",
        title: "Seashore Sprint",
        text: "She sells seashells by the seashore.",
        difficulty: .speaker,
        targetSounds: ["/s/", "/ʃ/"],
        normalDuration: 6.5,
        targetDuration: 7.0,
        rewardPoints: 45,
        difficultWords: ["seashells", "seashore"],
        vocabularyNotes: "Small shells found on the beach. Keep the \"sh\" soft and clear.",
        isDailyEligible: true
    )

    static let peterPiper = TongueTwister(
        id: "peters-pickle-pack",
        title: "Peter's Pickle Pack",
        text: "Peter Piper picked a peck of pickled peppers.",
        difficulty: .speaker,
        targetSounds: ["/p/"],
        normalDuration: 7.0,
        targetDuration: 8.0,
        rewardPoints: 40,
        difficultWords: ["peck", "pickled", "peppers"],
        vocabularyNotes: "A peck is an old measure of amount. Pop each \"p\" crisply.",
        isDailyEligible: true
    )

    static let woodchuck = TongueTwister(
        id: "woodchuck-wonder",
        title: "Woodchuck Wonder",
        text: "How much wood would a woodchuck chuck?",
        difficulty: .mover,
        targetSounds: ["/w/", "/tʃ/"],
        normalDuration: 5.5,
        targetDuration: 6.0,
        rewardPoints: 30,
        difficultWords: ["woodchuck", "chuck"],
        vocabularyNotes: "A woodchuck is a small furry animal. Keep the \"ch\" light.",
        isDailyEligible: true
    )

    static let bigBlackBug = TongueTwister(
        id: "big-black-bug",
        title: "Big Black Bug",
        text: "A big black bug bit a big black bear.",
        difficulty: .mover,
        targetSounds: ["/b/"],
        normalDuration: 5.0,
        targetDuration: 5.5,
        rewardPoints: 30,
        difficultWords: ["black", "bear"],
        vocabularyNotes: "Bounce off each \"b\" without rushing the words together.",
        isDailyEligible: false
    )

    static let redLorry = TongueTwister(
        id: "red-lorry",
        title: "Red Lorry",
        text: "Red lorry yellow lorry.",
        difficulty: .starter,
        targetSounds: ["/r/", "/l/"],
        normalDuration: 3.5,
        targetDuration: 4.0,
        rewardPoints: 20,
        difficultWords: ["lorry"],
        vocabularyNotes: "A lorry is a truck. Keep \"r\" and \"l\" from blending.",
        isDailyEligible: false
    )

    static let toyBoat = TongueTwister(
        id: "toy-boat",
        title: "Toy Boat",
        text: "Toy boat toy boat toy boat.",
        difficulty: .starter,
        targetSounds: ["/t/", "/b/"],
        normalDuration: 3.0,
        targetDuration: 3.5,
        rewardPoints: 20,
        difficultWords: ["boat"],
        vocabularyNotes: "Say it three times, clearly, without slurring.",
        isDailyEligible: false
    )

    static let all: [TongueTwister] = [
        seashore, peterPiper, woodchuck, bigBlackBug, redLorry, toyBoat
    ]

    static var daily: TongueTwister { woodchuck }

    static func library(for difficulty: Difficulty?) -> [TongueTwister] {
        guard let difficulty else { return all }
        return all.filter { $0.difficulty == difficulty }
    }

    // Frequently missed words for Mistake Review.
    static let missedWords: [MissedWord] = [
        MissedWord(word: "seashore", misses: 5, sound: "/ʃ/", note: "last practiced 2 days ago", trend: .highPriority),
        MissedWord(word: "peck", misses: 3, sound: "/p/", note: "last practiced today", trend: .improving),
        MissedWord(word: "woodchuck", misses: 0, sound: "/tʃ/", note: "Cleared from your review list", trend: .mastered)
    ]

    // Badges for the rewards grid.
    static let badges: [Badge] = [
        Badge(name: "First Twist", symbol: "flag.checkered", gradient: .brand, earned: true),
        Badge(name: "Clear Speaker", symbol: "waveform", gradient: .green, earned: true),
        Badge(name: "5-Day Streak", symbol: "flame.fill", gradient: .orange, earned: true),
        Badge(name: "Perfect Accuracy", symbol: "target", gradient: .gold, earned: true),
        Badge(name: "Speed Starter", symbol: "bolt.fill", gradient: .brand, earned: false),
        Badge(name: "Twist Master", symbol: "crown.fill", gradient: .brand, earned: false)
    ]
}

struct MissedWord: Identifiable {
    enum Trend { case highPriority, improving, mastered }
    let id = UUID()
    let word: String
    let misses: Int
    let sound: String
    let note: String
    let trend: Trend
}

struct Badge: Identifiable {
    enum Palette { case brand, green, orange, gold }
    let id = UUID()
    let name: String
    let symbol: String
    let gradient: Palette
    let earned: Bool
}

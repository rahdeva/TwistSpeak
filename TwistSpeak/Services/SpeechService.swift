//
//  SpeechService.swift
//  TwistSpeak
//
//  AVFoundation + Speech: microphone recording and on-device transcription
//  (PRD §17.4, §17.5, §23). Fails safely so denied permissions never crash.
//

import Foundation
import AVFoundation
import Speech
import Observation

@MainActor
@Observable
final class SpeechService {

    enum RecordingState { case idle, listening, finished }

    // Observable UI state
    var state: RecordingState = .idle
    var transcript: String = ""
    var level: Double = 0            // 0...1 mic level for the waveform
    var elapsed: TimeInterval = 0

    // Permission status
    var micAuthorized: Bool = false
    var speechAuthorized: Bool = false

    private let audioEngine = AVAudioEngine()
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var startTime: Date?
    private var timer: Timer?
    private var maxDuration: TimeInterval = 40
    private var onAutoStop: (() -> Void)?

    // MARK: - Permissions

    func requestMicPermission() async -> Bool {
        let granted = await withCheckedContinuation { cont in
            AVAudioApplication.requestRecordPermission { cont.resume(returning: $0) }
        }
        micAuthorized = granted
        return granted
    }

    func requestSpeechPermission() async -> Bool {
        let status = await withCheckedContinuation { cont in
            SFSpeechRecognizer.requestAuthorization { cont.resume(returning: $0) }
        }
        speechAuthorized = (status == .authorized)
        return speechAuthorized
    }

    func refreshAuthorization() {
        micAuthorized = AVAudioApplication.shared.recordPermission == .granted
        speechAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized
    }

    var isFullyAuthorized: Bool { micAuthorized && speechAuthorized }

    // MARK: - Recording lifecycle

    func start(maxDuration: TimeInterval, onAutoStop: @escaping () -> Void) {
        guard state != .listening else { return }
        self.maxDuration = maxDuration
        self.onAutoStop = onAutoStop
        transcript = ""
        elapsed = 0
        level = 0

        // Configure engine + recognition; if anything fails we still show the
        // listening UI so the flow stays usable (e.g. simulator with no mic).
        do {
            try configureSession()
            try beginRecognition()
        } catch {
            // Leave transcript empty → will resolve to a no-speech style outcome.
        }

        startTime = Date()
        state = .listening
        startTimer()
    }

    private func configureSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .measurement, options: .duckOthers)
        try session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func beginRecognition() throws {
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request

        let input = audioEngine.inputNode
        let format = input.outputFormat(forBus: 0)
        input.removeTap(onBus: 0)
        input.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            request.append(buffer)
            let rms = Self.rms(buffer)
            Task { @MainActor in self?.level = rms }
        }

        audioEngine.prepare()
        try audioEngine.start()

        if let recognizer, recognizer.isAvailable {
            task = recognizer.recognitionTask(with: request) { [weak self] result, _ in
                guard let self else { return }
                if let result {
                    Task { @MainActor in self.transcript = result.bestTranscription.formattedString }
                }
            }
        }
    }

    /// Stop recording and return the final transcript, duration and status.
    func stop() async -> (transcript: String, duration: TimeInterval, status: RecognitionStatus) {
        guard state == .listening else {
            return (transcript, elapsed, transcript.isEmpty ? .noSpeech : .success)
        }
        stopTimer()
        let duration = startTime.map { Date().timeIntervalSince($0) } ?? elapsed
        state = .finished

        audioEngine.inputNode.removeTap(onBus: 0)
        if audioEngine.isRunning { audioEngine.stop() }
        request?.endAudio()

        // Give the recognizer a brief moment to deliver a final transcript.
        try? await Task.sleep(for: .milliseconds(500))
        task?.finish()
        task = nil
        request = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        let final = transcript.trimmingCharacters(in: .whitespacesAndNewlines)
        let status: RecognitionStatus
        if !(recognizer?.isAvailable ?? false) {
            status = .unavailable
        } else if final.isEmpty {
            status = .noSpeech
        } else {
            status = .success
        }
        return (final, max(duration, 0.1), status)
    }

    func cancel() {
        stopTimer()
        audioEngine.inputNode.removeTap(onBus: 0)
        if audioEngine.isRunning { audioEngine.stop() }
        task?.cancel()
        task = nil
        request = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        state = .idle
        transcript = ""
        level = 0
        elapsed = 0
    }

    // MARK: - Helpers

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self, let start = self.startTime else { return }
                self.elapsed = Date().timeIntervalSince(start)
                if self.elapsed >= self.maxDuration {
                    self.stopTimer()
                    self.onAutoStop?()
                }
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private static func rms(_ buffer: AVAudioPCMBuffer) -> Double {
        guard let channel = buffer.floatChannelData?[0] else { return 0 }
        let n = Int(buffer.frameLength)
        guard n > 0 else { return 0 }
        var sum: Float = 0
        for i in 0..<n { let s = channel[i]; sum += s * s }
        let rms = (sum / Float(n)).squareRoot()
        // Map to a lively 0...1 range for the waveform.
        let scaled = min(1, Double(rms) * 12)
        return scaled
    }
}

//
//  Detail Data Model.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import Foundation
import AVFoundation
import Observation

@MainActor
@Observable
final class PlayerViewModel {
    var isPlaying = false
    var isBuffering = false
    var currentStation: RadioStation?
    var showError = false
    var errorMessage = ""

    private let player = AVPlayer()
    private var statusObserver: NSKeyValueObservation?

    init() {
        statusObserver = player.observe(\.timeControlStatus, options: [.new]) { [weak self] player, _ in
            Task { @MainActor [weak self] in
                self?.isPlaying = player.timeControlStatus == .playing
                self?.isBuffering = player.timeControlStatus == .waitingToPlayAtSpecifiedRate
            }
        }
    }

    func togglePlayback(for station: RadioStation) {
        if currentStation?.id == station.id && player.timeControlStatus != .paused {
            player.pause()
        } else {
            play(station)
        }
    }

    func stop() {
        player.pause()
        currentStation = nil
    }

    private func play(_ station: RadioStation) {
        guard let url = URL(string: station.url) else {
            errorMessage = "Ogiltig ström-URL"
            showError = true
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback)
            try session.setActive(true)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            return
        }
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
        currentStation = station
    }
}

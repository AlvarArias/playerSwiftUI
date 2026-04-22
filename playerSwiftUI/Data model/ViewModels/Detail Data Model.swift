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
    var currentStation: RadioStation?
    var showError = false
    var errorMessage = ""

    private let player = AVPlayer()

    func togglePlayback(for station: RadioStation) {
        if isPlaying && currentStation?.id == station.id {
            player.pause()
            isPlaying = false
        } else {
            play(station)
        }
    }

    func stop() {
        player.pause()
        isPlaying = false
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
        isPlaying = true
    }
}

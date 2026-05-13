//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import CachedAsyncImage

struct DetalleUIView: View {
    let station: RadioStation

    @Environment(PlayerViewModel.self) private var player
    @Environment(UserSettings.self) private var userSettings
    @State private var scheduleParser = ScheduleParser()
    @State private var pulseRings = false

    private var isCurrentStation: Bool { player.currentStation?.id == station.id }
    private var isPlaying: Bool { isCurrentStation && player.isPlaying }
    private var isBuffering: Bool { isCurrentStation && player.isBuffering }

    var body: some View {
        @Bindable var playerBinding = player

        ScrollView {
            VStack(spacing: 20) {

                // Station image
                CachedAsyncImage(url: URL(string: station.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }

                // Playback controls
                HStack(spacing: 24) {
                    ZStack {
                        // Buffering rings — visible only while stream is loading
                        ForEach(0..<2, id: \.self) { i in
                            Circle()
                                .stroke(Color.newSecundaryColor, lineWidth: 1.5)
                                .frame(width: 64, height: 64)
                                .scaleEffect(pulseRings ? 1.35 + Double(i) * 0.2 : 1.0)
                                .opacity(pulseRings ? 0 : 0.45)
                                .animation(
                                    pulseRings
                                        ? .easeOut(duration: 0.85).repeatForever(autoreverses: false).delay(Double(i) * 0.28)
                                        : .none,
                                    value: pulseRings
                                )
                        }

                        Button {
                            player.togglePlayback(for: station)
                        } label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 64))
                                .foregroundStyle(Color.newSecundaryColor)
                        }
                        .accessibilityLabel(isPlaying ? "Pausa" : "Spela")
                    }
                    .onChange(of: isBuffering) { _, buffering in
                        pulseRings = buffering
                    }

                    Button {
                        userSettings.toggleFavorite(station.id)
                    } label: {
                        Image(systemName: userSettings.isFavorite(station.id) ? "star.fill" : "star")
                            .font(.title)
                            .foregroundStyle(userSettings.isFavorite(station.id) ? .yellow : .primary)
                    }
                    .accessibilityLabel(userSettings.isFavorite(station.id) ? "Ta bort favorit" : "Lägg till favorit")
                }

                // Lottie equalizer — only when this station is playing
                if isPlaying {
                    LottieView(lottieFile: "music-equalizer", isPlaying: isPlaying)
                        .frame(width: 60, height: 60)
                        .transition(.opacity.combined(with: .scale(scale: 0.8)))
                }

                // Schedule section
                Text("Nästa program")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                ScheduleView(parser: scheduleParser)
            }
        }
        .navigationTitle(station.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await scheduleParser.fetchSchedule(from: station.scheduleurl)
        }
        .alert("Uppspelningsfel", isPresented: $playerBinding.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(player.errorMessage)
        }
    }
}

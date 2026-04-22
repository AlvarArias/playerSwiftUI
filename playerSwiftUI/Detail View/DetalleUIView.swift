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

    private var isCurrentStation: Bool { player.currentStation?.id == station.id }
    private var isPlaying: Bool { isCurrentStation && player.isPlaying }

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
                    Button {
                        player.togglePlayback(for: station)
                    } label: {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                            .foregroundStyle(Color.newSecundaryColor)
                    }
                    .accessibilityLabel(isPlaying ? "Pausa" : "Spela")

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
                    LottieView(lottieFile: "music-equalizer")
                        .frame(width: 60, height: 60)
                        .transition(.opacity)
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

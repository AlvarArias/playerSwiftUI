//
//  FavoriteDispView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-31.
//

import SwiftUI
import CachedAsyncImage

struct FavoriteDispView: View {
    @Environment(StationStore.self) private var stationStore
    @Environment(UserSettings.self) private var userSettings
    @Environment(\.dismiss) private var dismiss

    private var favoriteStations: [RadioStation] {
        stationStore.stations.filter { userSettings.isFavorite($0.id) }
    }

    var body: some View {
        NavigationStack {
            List(favoriteStations) { station in
                HStack {
                    CachedAsyncImage(url: URL(string: station.image)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }

                    Text(station.tagline)
                        .font(.body)
                        .lineLimit(3)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)

                    NavigationLink(destination: DetalleUIView(station: station)) {
                        EmptyView()
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(Color.newColorGrayLight)
            .navigationTitle("Favoriter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button { dismiss() } label: { ArrowToolBarView() }
                }
            }
        }
    }
}

#Preview {
    FavoriteDispView()
        .environment(StationStore())
        .environment(UserSettings())
        .environment(PlayerViewModel())
}

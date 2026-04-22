//
//  SerachView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-18.
//

import SwiftUI
import CachedAsyncImage

struct SearchView: View {
    @Environment(StationStore.self) private var stationStore
    @Environment(UserSettings.self) private var userSettings
    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""

    private var searchResults: [RadioStation] {
        if searchText.isEmpty { return stationStore.stations }
        return stationStore.stations.filter {
            $0.tagline.localizedCaseInsensitiveContains(searchText) ||
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(searchResults) { station in
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

                    Image(systemName: userSettings.isFavorite(station.id) ? "star.fill" : "star")
                        .foregroundStyle(userSettings.isFavorite(station.id) ? .yellow : .secondary)

                    NavigationLink(destination: DetalleUIView(station: station)) {
                        EmptyView()
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(Color.newColorGrayLight)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Sök")
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
    SearchView()
        .environment(StationStore())
        .environment(UserSettings())
        .environment(PlayerViewModel())
}

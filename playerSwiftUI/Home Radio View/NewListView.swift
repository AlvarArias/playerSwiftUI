//
//  NewListView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import SwiftUI
import CachedAsyncImage

struct NewListView: View {
    @Environment(StationStore.self) private var stationStore
    @Environment(UserSettings.self) private var userSettings
    @State private var isVisible = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(stationStore.stations) { station in
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
                            .font(.caption)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image(systemName: userSettings.isFavorite(station.id) ? "star.fill" : "star")
                            .foregroundStyle(userSettings.isFavorite(station.id) ? .yellow : .secondary)

                        NavigationLink(destination: DetalleUIView(station: station)) {
                            Image(systemName: "arrow.forward.circle")
                                .foregroundStyle(Color.black.opacity(0.85))
                        }
                        .accessibilityValue(station.id)
                    }
                    .padding(15)
                    .background(Color.newPrimaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                    .padding(.horizontal)
                    .opacity(isVisible ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 1.5), value: isVisible)
                }
            }
        }
        .onAppear { isVisible = true }
    }
}

#Preview {
    NewListView()
        .environment(StationStore())
        .environment(UserSettings())
}

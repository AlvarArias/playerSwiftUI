//
//  favoriteButtonView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import SwiftUI

struct FavoriteButton: View {
    let stationId: String
    @Environment(UserSettings.self) private var userSettings

    var body: some View {
        Button {
            userSettings.toggleFavorite(stationId)
        } label: {
            Image(systemName: userSettings.isFavorite(stationId) ? "star.fill" : "star")
                .foregroundStyle(userSettings.isFavorite(stationId) ? .yellow : .primary)
        }
        .accessibilityLabel(userSettings.isFavorite(stationId) ? "Ta bort favorit" : "Lägg till favorit")
    }
}

#Preview {
    FavoriteButton(stationId: "132")
        .environment(UserSettings())
}

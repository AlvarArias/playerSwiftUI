//
//  mySettings.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import Foundation
import Observation

@MainActor
@Observable
final class UserSettings {
    var username: String {
        didSet { UserDefaults.standard.set(username, forKey: "username") }
    }
    var preferredStation: String {
        didSet { UserDefaults.standard.set(preferredStation, forKey: "ringtone") }
    }
    var favorites: [String] {
        didSet { UserDefaults.standard.set(favorites, forKey: "SavedFavoriteUS") }
    }

    let availableStations = ["P1", "P2", "P3"]

    init() {
        username = UserDefaults.standard.string(forKey: "username") ?? ""
        preferredStation = UserDefaults.standard.string(forKey: "ringtone") ?? "P1"
        favorites = UserDefaults.standard.array(forKey: "SavedFavoriteUS") as? [String] ?? []
    }

    func isFavorite(_ id: String) -> Bool {
        favorites.contains(id)
    }

    func toggleFavorite(_ id: String) {
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
        } else {
            favorites.append(id)
        }
    }
}

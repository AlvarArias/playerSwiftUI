//
//  HomeModell.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import Foundation
import Observation

@MainActor
@Observable
final class StationStore {
    var stations: [RadioStation] = []

    func load() {
        guard let url = Bundle.main.url(forResource: "radios23", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        do {
            stations = try JSONDecoder().decode([RadioStation].self, from: data)
        } catch {
            print("StationStore: \(error)")
        }
    }
}

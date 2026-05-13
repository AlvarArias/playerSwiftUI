//
//  HomeModell.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import Foundation
import Observation

// MARK: - Private SR schedule decode types

private struct SRScheduleAPIResponse: Decodable {
    let schedule: [SRScheduleItem]
}

private struct SRScheduleItem: Decodable {
    let imageurl: String?
    let starttimeutc: String
    let endtimeutc: String

    var startDate: Date? { microsoftDate(starttimeutc) }
    var endDate: Date? { microsoftDate(endtimeutc) }

    private func microsoftDate(_ raw: String) -> Date? {
        guard
            let open = raw.firstIndex(of: "("),
            let close = raw.firstIndex(of: ")"),
            let ms = Double(raw[raw.index(after: open)..<close])
        else { return nil }
        return Date(timeIntervalSince1970: ms / 1000)
    }
}

// MARK: - StationStore

@MainActor
@Observable
final class StationStore {
    var stations: [RadioStation] = []
    var nowPlayingImages: [String: String] = [:]

    func load() {
        guard let url = Bundle.main.url(forResource: "radios23", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        do {
            stations = try JSONDecoder().decode([RadioStation].self, from: data)
        } catch {
            print("StationStore: \(error)")
            return
        }
        Task {
            let images = await Self.loadNowPlayingImages(for: stations)
            nowPlayingImages = images
        }
    }

    private static func loadNowPlayingImages(for stations: [RadioStation]) async -> [String: String] {
        await withTaskGroup(of: (String, String?).self) { group in
            for station in stations {
                group.addTask {
                    let image = try? await fetchEpisodeImageURL(channelID: station.id)
                    return (station.id, image)
                }
            }
            var result: [String: String] = [:]
            for await (id, image) in group {
                if let image { result[id] = image }
            }
            return result
        }
    }

    private static func fetchEpisodeImageURL(channelID: String) async throws -> String? {
        guard let url = URL(string: "https://api.sr.se/api/v2/scheduledepisodes?channelid=\(channelID)&format=json&size=100") else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SRScheduleAPIResponse.self, from: data)
        let now = Date()
        if let current = response.schedule.first(where: {
            ($0.startDate ?? .distantPast) <= now && ($0.endDate ?? .distantFuture) >= now
        }) {
            return current.imageurl
        }
        return response.schedule
            .filter { ($0.startDate ?? .distantFuture) <= now }
            .max(by: { ($0.startDate ?? .distantPast) < ($1.startDate ?? .distantPast) })?
            .imageurl
    }
}

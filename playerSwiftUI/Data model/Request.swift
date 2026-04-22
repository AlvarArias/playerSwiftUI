//
//  Request.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-19.
//

import Foundation
import Observation

struct ScheduledEpisode: Sendable {
    let title: String
    let description: String
    let startTimeUTC: String
}

// Non-isolated helper: runs synchronously inside ScheduleParser.fetchSchedule (always on main actor).
private final class XMLEpisodeParser: NSObject, XMLParserDelegate, @unchecked Sendable {
    private(set) var episodes: [ScheduledEpisode] = []
    private var currentElement = ""
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentStartTime = ""

    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName: String?,
                attributes: [String: String] = [:]) {
        if elementName == "scheduledepisode" {
            currentTitle = ""
            currentDescription = ""
            currentStartTime = ""
        }
        currentElement = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName: String?) {
        guard elementName == "scheduledepisode" else { return }
        episodes.append(ScheduledEpisode(
            title: currentTitle,
            description: currentDescription,
            startTimeUTC: currentStartTime
        ))
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let text = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        switch currentElement {
        case "title":        currentTitle += text
        case "description":  currentDescription += text
        case "starttimeutc": currentStartTime += text
        default: break
        }
    }
}

@MainActor
@Observable
final class ScheduleParser {
    var episodes: [ScheduledEpisode] = []
    var isLoading = false

    func fetchSchedule(from urlString: String) async {
        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let xmlHelper = XMLEpisodeParser()
            let parser = XMLParser(data: data)
            parser.delegate = xmlHelper
            parser.parse()
            episodes = xmlHelper.episodes
        } catch {
            print("ScheduleParser: \(error)")
        }
    }
}

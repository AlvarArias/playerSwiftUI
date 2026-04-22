//
//  HomeModellTests.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2023-08-25.
//

import XCTest
@testable import playerSwiftUI

@MainActor
final class UserSettingsTests: XCTestCase {

    var settings: UserSettings!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "SavedFavoriteUS")
        settings = UserSettings()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "SavedFavoriteUS")
        settings = nil
        super.tearDown()
    }

    func testInitialFavorites_isEmpty() {
        XCTAssertTrue(settings.favorites.isEmpty)
    }

    func testIsFavorite_unknownId_returnsFalse() {
        XCTAssertFalse(settings.isFavorite("unknown"))
    }

    func testToggleFavorite_addsStation() {
        settings.toggleFavorite("132")
        XCTAssertTrue(settings.isFavorite("132"))
    }

    func testToggleFavorite_removesExisting() {
        settings.toggleFavorite("132")
        settings.toggleFavorite("132")
        XCTAssertFalse(settings.isFavorite("132"))
    }

    func testToggleFavorite_multipleStations_tracksEachIndependently() {
        settings.toggleFavorite("132")
        settings.toggleFavorite("163")
        XCTAssertTrue(settings.isFavorite("132"))
        XCTAssertTrue(settings.isFavorite("163"))
        XCTAssertFalse(settings.isFavorite("999"))
    }

    func testAvailableStations_notEmpty() {
        XCTAssertFalse(settings.availableStations.isEmpty)
    }
}

@MainActor
final class StationStoreTests: XCTestCase {

    func testInitialStations_isEmpty() {
        let store = StationStore()
        XCTAssertTrue(store.stations.isEmpty)
    }

    func testLoad_populatesStations() {
        let store = StationStore()
        store.load()
        XCTAssertFalse(store.stations.isEmpty)
    }

    func testLoad_stationsHaveRequiredFields() {
        let store = StationStore()
        store.load()
        guard let station = store.stations.first else {
            XCTFail("No stations loaded")
            return
        }
        XCTAssertFalse(station.id.isEmpty)
        XCTAssertFalse(station.name.isEmpty)
        XCTAssertFalse(station.url.isEmpty)
    }

    func testLoad_stationURLsAreValid() {
        let store = StationStore()
        store.load()
        for station in store.stations {
            XCTAssertNotNil(URL(string: station.url), "Invalid URL for station \(station.id): \(station.url)")
        }
    }
}

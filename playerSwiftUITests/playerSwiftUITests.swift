//
//  playerSwiftUITests.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2022-08-22.
//

import XCTest
@testable import playerSwiftUI

@MainActor
final class PlayerViewModelTests: XCTestCase {

    var viewModel: PlayerViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PlayerViewModel()
    }

    override func tearDown() {
        viewModel.stop()
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertFalse(viewModel.isPlaying)
        XCTAssertNil(viewModel.currentStation)
        XCTAssertFalse(viewModel.showError)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testTogglePlayback_withInvalidURL_showsError() {
        let station = RadioStation(
            id: "999",
            name: "Test",
            image: "",
            imagetemplate: "",
            color: "",
            tagline: "Test station",
            siteurl: "",
            url: "not a valid url",  // space makes URL(string:) return nil
            scheduleurl: "",
            xmltvid: ""
        )
        viewModel.togglePlayback(for: station)
        XCTAssertTrue(viewModel.showError)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.isPlaying)
        XCTAssertNil(viewModel.currentStation)
    }

    func testTogglePlayback_withValidURL_setsCurrentStation() {
        let station = RadioStation(
            id: "132",
            name: "P1",
            image: "",
            imagetemplate: "",
            color: "",
            tagline: "Sveriges Radio P1",
            siteurl: "",
            url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3",
            scheduleurl: "",
            xmltvid: ""
        )
        viewModel.togglePlayback(for: station)
        XCTAssertTrue(viewModel.isPlaying)
        XCTAssertEqual(viewModel.currentStation?.id, "132")
    }

    func testTogglePlayback_sameStation_pauses() {
        let station = RadioStation(
            id: "132",
            name: "P1",
            image: "",
            imagetemplate: "",
            color: "",
            tagline: "Sveriges Radio P1",
            siteurl: "",
            url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3",
            scheduleurl: "",
            xmltvid: ""
        )
        viewModel.togglePlayback(for: station)
        XCTAssertTrue(viewModel.isPlaying)
        viewModel.togglePlayback(for: station)
        XCTAssertFalse(viewModel.isPlaying)
    }

    func testStop_clearsAllState() {
        let station = RadioStation(
            id: "132",
            name: "P1",
            image: "",
            imagetemplate: "",
            color: "",
            tagline: "Sveriges Radio P1",
            siteurl: "",
            url: "https://sverigesradio.se/topsy/dirakt/srapi/132.mp3",
            scheduleurl: "",
            xmltvid: ""
        )
        viewModel.togglePlayback(for: station)
        viewModel.stop()
        XCTAssertFalse(viewModel.isPlaying)
        XCTAssertNil(viewModel.currentStation)
    }
}

//
//  NetworkMonitorTest.swift
//  playerSwiftUITests
//
//  Created by Alvar Arias on 2026-04-22.
//

import XCTest
@testable import playerSwiftUI

@MainActor
final class NetworkMonitorTests: XCTestCase {

    func testInitialState_isConnected() {
        let monitor = NetworkMonitor()
        XCTAssertTrue(monitor.isConnected)
    }
}

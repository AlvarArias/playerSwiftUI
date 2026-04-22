//
//  network_checker.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import Foundation
import Network
import Observation

@MainActor
@Observable
final class NetworkMonitor {
    private(set) var isConnected = true

    private let monitor = NWPathMonitor()

    init() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { [weak self] path in
            let connected = path.status == .satisfied
            Task { @MainActor [weak self] in
                self?.isConnected = connected
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

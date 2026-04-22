//
//  playerSwiftUIApp.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2021-12-07.
//

import SwiftUI

@main
struct playerSwiftUIApp: App {
    @State private var stationStore = StationStore()
    @State private var player = PlayerViewModel()
    @State private var userSettings = UserSettings()
    @State private var networkMonitor = NetworkMonitor()
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            HomeRadioView()
                .environment(stationStore)
                .environment(player)
                .environment(userSettings)
                .environment(networkMonitor)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .task { stationStore.load() }
        }
    }
}

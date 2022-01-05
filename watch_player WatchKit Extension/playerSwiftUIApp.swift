//
//  playerSwiftUIApp.swift
//  watch_player WatchKit Extension
//
//  Created by Alvar Arias on 2021-12-08.
//

import SwiftUI

@main
struct playerSwiftUIApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

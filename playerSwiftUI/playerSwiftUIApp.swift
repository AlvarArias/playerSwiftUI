//
//  playerSwiftUIApp.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2021-12-07.
//

import SwiftUI

@main
struct playerSwiftUIApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashSwiftUIView()
            //FavoritesView()
            //TestSongView(resultado2: .init(title: "title", description: "description", artist: "artist", composer: "composer", conductor: "conductor", albumname: "albumname", recordlabel: "recordlabel", producer: "producer"))
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
        }
    }
}


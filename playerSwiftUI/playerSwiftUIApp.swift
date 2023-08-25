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
            //SplashSwiftUIView()
            HomeRadioView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
        }
    }
}


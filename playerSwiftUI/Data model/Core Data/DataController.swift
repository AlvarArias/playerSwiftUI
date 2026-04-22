//
//  DataController.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-28.
//

import CoreData

@MainActor
final class DataController {
    let container = NSPersistentContainer(name: "ModelPlayer")

    init() {
        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

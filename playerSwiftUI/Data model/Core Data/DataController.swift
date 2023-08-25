//
//  DataController.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-28.
//

import CoreData
import Foundation

/**
A class that manages a Core Data stack and provides access to a persistent store.

Usage: Initialize an instance of DataController to get a Core Data stack and access to a persistent store.

*/
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ModelPlayer")
    
    init () {
        container.loadPersistentStores { description, error in
                                        if let error = error {
            print("Core Data failed to load. \(error.localizedDescription)")
            }
        }
    }
}



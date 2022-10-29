//
//  DataController.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-28.
//

import CoreData
import Foundation


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



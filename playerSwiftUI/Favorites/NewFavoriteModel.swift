//
//  NewFavoriteModel.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-31.
//

import Foundation


struct Task: Encodable {
    var id : String
}



class myFavorites: ObservableObject {
    private var tasks: Set<String>
    let defaults = UserDefaults.standard
    
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: "myFavorites") as? Data {
            let taskData = try? decoder.decode(Set<String>.self, from: data)
            self.tasks = taskData ?? []
        } else {
            self.tasks = []
        }
    }
    
    func getTaskIds() -> Set<String> {
        return self.tasks
    }
    
    func isEmpty() -> Bool {
        tasks.count < 1
    }
    
    func contains(_ task: Task) -> Bool {
        tasks.contains(task.id)
    }
    
    func add(_ task: Task) {
        objectWillChange.send()
        tasks.insert(task.id)
        save()
    }
    
    func remove(_ task: Task) {
        objectWillChange.send()
        tasks.remove(task.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        //if let encoded = try? encoder.encode(myFavorites) {
            //defaults.set(encoded, forKey: "myFavorites")
        }
    }


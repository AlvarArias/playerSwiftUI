//
//  Detail Data Model.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import Foundation
import SwiftUI
import AVKit

struct favoriteSaved : Decodable,Encodable, Hashable {
    var favoriteId : [String]
    
    init() {
            self.favoriteId = []
        }
 
}


class theURLSetting : ObservableObject {
    @Published var theURL: String = ""
    @Published var isFavorite : Bool = false
}


class PlayRadio {
    
    var player = AVPlayer()
    
    func playSongRadio(radioURL: String, isPlaying: Bool) -> Bool {
        

        do {
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
            
            player = AVPlayer(url: URL(string: radioURL)!)
        
            
            if isPlaying {
                player.play()
                return true
                
            } else {
                
                player.pause()
                return false
            }
            
            
        } catch let error {
            print("Failed to play audio: \(error.localizedDescription)")
            return false
        }
        
    }
    
}


protocol DataManager {
    func manageData(data: String, userSettings: UserSettings) -> Bool
}

// Asigno una responsabilidad a cada clase

class saveFavorite : DataManager {
    
    //@ObservedObject var userSettings = UserSettings()
    
    func manageData(data: String, userSettings: UserSettings) -> Bool {
        
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        // verificar si existe
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data,
           var loadFavorite = try? decoder.decode(favoriteSaved.self, from: savedPerson),
           !loadFavorite.favoriteId.contains(data) {
            
            // si no existe grabar
            loadFavorite.favoriteId.append(data)

            // Save data
            if let encoded = try? encoder.encode(loadFavorite) {
                defaults.set(encoded, forKey: "SavedPerson")
            }

            return true

        }
            
        return false
    }
    
    
}

class deleteFavorite: DataManager {
    
    func manageData(data: String, userSettings: UserSettings) -> Bool {
        
        //@ObservedObject var userSettings = UserSettings()

        if let index = userSettings.favorite.firstIndex(of: data) {
            
            userSettings.favorite.remove(at: index)
            return true
        }
        
        return false
    }
    
}

class checkFavoriteC: DataManager {
    
    func manageData(data: String, userSettings: UserSettings) -> Bool {
        
        let isFavorite = userSettings.favorite.contains(data)
                
        return isFavorite
        
    }
    
    
}


// Mock for testing
// Check if is favorite or not

protocol myDataManager {
    func manageData(data: String, userSettings: myUserSettings) -> Bool
}


struct myUserSettings {
    var favorite: [String]
}

class YourDataManager: myDataManager {
    func manageData(data: String, userSettings: myUserSettings) -> Bool {
        let isFavorite = userSettings.favorite.contains(data)
        return isFavorite
    }
}

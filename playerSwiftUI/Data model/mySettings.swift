//
//  mySettings.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var username: String {
        didSet{
            UserDefaults.standard.set(username, forKey: "username")
        }
    }

    @Published var isPrivate: Bool {
        didSet {
            UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate")
        }
    }

    @Published var ringtone: String {
        didSet {
            UserDefaults.standard.set(ringtone, forKey: "ringtone")
        }
    }
    
    @Published var favorite: String {
        didSet {
            UserDefaults.standard.set(favorite, forKey: "SavedFavoriteUS")
        }
    }
    
    public var ringtones = ["P1", "P2", "P3"]
    
    
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        
        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
        
        self.ringtone = UserDefaults.standard.object(forKey: "ringtone") as? String ?? "P1"
        
        self.favorite = UserDefaults.standard.object(forKey: "SavedFavoriteUS") as? String ?? "p1"
    
    }
    
}

//
//  mySettings.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import Foundation
import Combine

/**
A class that manages user settings and stores them in UserDefaults.

Usage: Initialize an instance of UserSettings to manage and store user settings.

*/
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

        @Published var favorite: [String] {
            didSet {
                UserDefaults.standard.set(favorite, forKey: "SavedFavoriteUS")
            }
        }
        
        public var ringtones = ["P1", "P2", "P3"]
   
       init() {
           self.username = UserDefaults.standard.string(forKey: "username") ?? ""
           self.isPrivate = UserDefaults.standard.bool(forKey: "isAccountPrivate")
           self.ringtone = UserDefaults.standard.string(forKey: "ringtone") ?? "P1"
           self.favorite = UserDefaults.standard.array(forKey: "SavedFavoriteUS") as? [String] ?? ["p1"]
       }

       
    }

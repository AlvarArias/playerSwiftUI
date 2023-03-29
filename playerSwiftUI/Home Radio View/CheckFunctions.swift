//
//  CheckFunctions.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import Foundation

/// Check if a radio station is saved as a favorite.
///
/// - Parameters:
///   - myRadioFavo: The name of the radio station to check.
///
/// - Returns: A Boolean value indicating whether the radio station is saved as a favorite.
///
/// This function checks if a radio station is saved as a favorite in the app's saved data.

struct checkFavorite {
    
    // User defaults for favorites
    let defaults = UserDefaults.standard
    
    func checkIsFavorite(myRadioFavo: String) -> Bool {
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                if loadedPerson.mytest.contains(where: { $0 == myRadioFavo }) {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
    
}


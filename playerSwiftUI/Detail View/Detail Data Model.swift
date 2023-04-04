//
//  Detail Data Model.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import Foundation
import SwiftUI


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





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
            
            if isPlaying {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.playback)
                print("AVAudioSession Category Playback OK")
                
                try audioSession.setActive(true)
                print("AVAudioSession is Active")
                
                player = AVPlayer(url: URL(string: radioURL)!)
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


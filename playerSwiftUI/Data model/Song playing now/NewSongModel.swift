//
//  NewSongModel.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-11-02.
//

import Foundation

// MARK: - Welcome
struct mySongNow2: Codable {
    let playlist: Playlist2
}

// MARK: - Playlist
struct Playlist2: Codable {
    var previoussong, song: Song2?
    //let previoussong: Song2
    //let channel: Channel
}

// MARK: - Channel
struct Channel: Codable {
    let id: Int
    let name: String
  
}

// MARK: - Song
struct Song2: Codable {
    var title, description, artist, composer: String
    var conductor, albumname, recordlabel, producer: String
    //let starttimeutc, stoptimeutc: String
   
    /*
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case artist = "artist"
        case composer = "composer"
        case conductor = "conductor "
        case albumname = "albumname"
        case recordlabel = "recordlabel"
        case producer = "producer"
        //case starttimeutc = "starttimeutc"
        //case stoptimeutc = "stoptimeutc"
    }
    */
}

/**
 {
   "playlist": {
     "previoussong": {
       "title": "After The Earthquake",
       "description": "Alvvays - After The Earthquake",
       "artist": "Alvvays",
       "composer": "Alec O'Hanley/Molly Rankin",
       "conductor": "",
       "albumname": "Blue Rev",
       "recordlabel": "",
       "producer": "",
       "starttimeutc": "/Date(1667397823000)/",
       "stoptimeutc": "/Date(1667398005000)/"
     },
     "song": {
       "title": "Cuff It",
       "description": "Beyoncé - Cuff It",
       "artist": "Beyoncé",
       "composer": "Nile Rodgers/Brittany @Chi_Coney Coney/Raphael Saadiq/Morten Ristorp/Mary Christine Brockert/Denisia Blu June Andrews/Beyoncé/Terius The-Dream Gesteelde-Diamant/Allen Henry Mcgrier",
       "conductor": "",
       "albumname": "",
       "recordlabel": "SONY MUSIC",
       "producer": "",
       "starttimeutc": "/Date(1667398008000)/",
       "stoptimeutc": "/Date(1667398233000)/"
     },
     "channel": {
       "id": 164,
       "name": "P3"
     }
   }
 }
 
 */

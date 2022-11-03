//
//  song.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-17.
//

import Foundation

struct SongNow: Codable {
    var playlist: Playlist
}

struct Playlist: Codable {
    var song: Song?

}

struct Song: Codable {
    var title, songdescription, artist, composer: String
    var conductor, albumname, recordlabel, producer: String
    var starttimeutc, stoptimeutc: String
}

/**
 {
   "playlist": {
     "previoussong": {
       "title": "BREAK MY SOUL",
       "description": "Beyoncé - BREAK MY SOUL",
       "artist": "Beyoncé",
       "composer": "Beyoncé/Allen George/Fred McFarlane/Terius Nash/Christopher Stewart/S. Carter/Adam Pigott/Freddie Ross/Jason White",
       "conductor": "",
       "albumname": "Renaissance",
       "recordlabel": "SONY MUSIC",
       "producer": "",
       "starttimeutc": "/Date(1660718960000)/",
       "stoptimeutc": "/Date(1660719236000)/"
     },
     "song": {
       "title": "Stockholmsvy",
       "description": "Hannes & Waterbaby - Stockholmsvy",
       "artist": "Hannes & Waterbaby",
       "composer": "Marcus White/Hannes Jonsson/Kendra Egerbladh",
       "conductor": "",
       "albumname": "",
       "recordlabel": "",
       "producer": "",
       "starttimeutc": "/Date(1660719518000)/",
       "stoptimeutc": "/Date(1660719678000)/"
     },
     "channel": {
       "id": 164,
       "name": "P3"
     }
   }
 }
 */

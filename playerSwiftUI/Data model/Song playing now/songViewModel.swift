//
//  songViewModell.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-17.
//

import Foundation

final class SongViewModel: ObservableObject {
    
    //@Published var users: [User] = []
    @Published var mySongNow: Playlist = Playlist(song: Song(title: "", songdescription: "", artist: "", composer: "", conductor: "", albumname: "", recordlabel: "", producer: "", starttimeutc: "", stoptimeutc: ""))
    @Published var hasError = false
    @Published var error: UserError?
    @Published private(set) var isRefreshing = false
    
    func fetchUsers() {
        
        isRefreshing = true
        hasError = false
        
        let userUrlString = "http://api.sr.se/api/v2/playlists/rightnow?channelid=163&format=JSON"
        if let url = URL(string: userUrlString) {
        
        URLSession
            .shared
            .dataTask(with: url) { [weak self]data, response, error in
           
                DispatchQueue.main.async {
                    
                    if let error = error {
                        self?.hasError = false
                        self?.error = UserError.custom(error: error)
                        
                        
                    } else {
                        
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle propieties that look like first_name > firstname
                        
                        if let data = data,
                            let theSong = try? decoder.decode(Playlist.self, from: data){
                            // TODO: Handle setting the data
                            print(data)
                            print("theSong")
                            print(theSong)
                            print(theSong.song?.artist ?? "no artist")
    
                        } else {
                            self?.hasError = true
                            self?.error = UserError.failToDecode
                        }
                    }
                    self?.isRefreshing = false
                }
             
            }.resume()
        }
    }
}

extension SongViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failToDecode
        
        var errorDescription: String?{
            switch self {
            case .failToDecode:
                return "failled to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}

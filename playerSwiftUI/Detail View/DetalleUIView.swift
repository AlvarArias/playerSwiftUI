//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import AVKit
import Lottie
import CachedAsyncImage

// Data Models
struct radioStationInfo: Identifiable {
    let id: String
    let name: String
    let image: String
    let color: String
    let tagline: String
    let siteurl: String
    let url: String
    let scheduleurl: String
    let imagetemplate: String
    let xmltvid: String
}

struct favoriteSaved: Codable {
    var favoriteId: [String]
}

struct UserSettings: ObservableObject {
    var favorite: [String] = []
}

// ViewModel
class DetalleUIViewViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var isShowEq: Bool = false
    @Published var receivedURL: URL?
    @Published var userSettings: UserSettings = UserSettings()
    
    func playSongRadio(radioURL: String, isPlaying: Bool) -> Bool {
        // Simulate playing the song and updating the equalizer
        // Add logic to handle actual audio playback here
        print("playing the song \(radioURL)")
        return isPlaying
    }
    
    func togglePlay() {
        isPlaying = !isPlaying
    }
}


struct DetalleUIView: View {
    @StateObject private var viewModel = DetalleUIViewViewModel()

    @Environment(\.presentationMode) var presentationMode
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    // Radio Object
    @StateObject var receivedURLSetting = theURLSetting()
    
    // Ver si se esta usando
    var choice: String
    
    @State private var selectedRadioStation : radioStationInfo
    @State private var isPlaying : Bool = false
    @State private var showingStar = false
    @State private var isShowEq = false
    @State private var isFavorite = false
    @State private var controlFunc = true
    @State private var isDataSaved = false
    
    
    let defaults = UserDefaults.standard
    
    // Data user default
    var myData = favoriteSaved()
    
    var playRadio = PlayRadio()
    
    var body: some View {
        VStack {
            CachedAsyncImage (url: URL(string: selectedRadioStation.image), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            },
                              placeholder: {
                ProgressView()
            })
            
            HStack{
                Text("Nästa program").padding()
                    .accessibilityLabel("Nästa program")
                
                Button {
                    showingStar.toggle()
                    
                    if userSettings.favorite.contains(selectedRadioStation.id) {
                        deleteFavorite(delFavorite: selectedRadioStation.id)
                        
                    } else {
                        userSettings.favorite.append(selectedRadioStation.id)
                        
                    }
                    
                    viewModel.userSettings = userSettings // Update ViewModel
                    
                } label: {
                    Image(systemName: showingStar || checkIsFavorite(myFavoriteSetting: selectedRadioStation.id) ? "star.fill" : "star")
                        .foregroundColor(showingStar || checkIsFavorite(myFavoriteSetting: selectedRadioStation.id) ? .yellow : .black)
                }
                
                
            }
            
            if isShowEq {
                LottieView(lottieFile: "music-equalizer")
                    .frame(width: 50, height: 50)
            }
            
            Button {
                viewModel.togglePlay()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
            }

        }
        .onAppear(perform: {
            receivedURLSetting.theURL = selectedRadioStation.scheduleurl
            print("receivedURLSetting.theURL \(receivedURLSetting.theURL)")
            print("Favorites \(userSettings.favorite)")
            
        })
        .environmentObject(viewModel)
    }
    
    // Funciones Favorites
    
    func saveData(myData: favoriteSaved) {
        
        if controlFunc {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(myData) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedPerson")
                print("End saveData(myData: Person)")
                print(defaults.stringArray(forKey: "SavedPerson") ?? "No value encoded Save Data()")
                
                controlFunc = false
            }
        }
    }
    
    func saveNewData() {
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data,
           var loadedPerson = try? JSONDecoder().decode(favoriteSaved.self, from: savedPerson),
           !loadedPerson.favoriteId.contains(selectedRadioStation.id) {
            
            loadedPerson.favoriteId.append(selectedRadioStation.id)
            print("saveNewData()")
            print(loadedPerson.favoriteId)
            saveData(myData: loadedPerson)
            print("new element added")
        } else {
            print("no data saveNewData() or element already exists")
        }
    }
    
    
    func deleteFavorite(delFavorite: String) {
        if let index = userSettings.favorite.firstIndex(of: delFavorite) {
            userSettings.favorite.remove(at: index)
            print("Element removed from userSettings.favorite: \(delFavorite)")
        } else {
            print("Element not found in userSettings.favorite: \(delFavorite)")
        }
        showingStar = false
    }
    
    func checkIsFavorite(myFavoriteSetting: String) -> Bool {
        return userSettings.favorite.contains(myFavoriteSetting)
    }
    
}

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


struct DetalleUIView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    // Radio Object
    @StateObject var receivedURL = theURLSetting()
    
    // Ver si se esta usando
    var choice: String
    
    @State var selectedRadioStation : radioStationInfo
    
    // Player variables
    @State private var player = AVPlayer()
    //let url1  = "https://sverigesradio.se/topsy/direkt/srapi/2562.mp3"
    @State private var isPlaying : Bool = false
    @State private var volum : Float = 0
    @State private var sliderValue: Double = 0
    
    @State var showingStar = false
    @State private var isShowEq = false
    @State private var isFavorite = false
    @State private var controlFunc = true
    
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
                
                
                // Button favorite
                
                Button {
                    
                    showingStar.toggle()
                    
                    if userSettings.favorite.contains(selectedRadioStation.id) {
                        deleteFavorite(delFavorite: selectedRadioStation.id)
                        
                        
                    } else {
                        userSettings.favorite.append(selectedRadioStation.id)
                        
                    }
                    
                    receivedURL.isFavorite = showingStar
                    
                } label: {
                    Image(systemName: showingStar || checkIsFavorite(myFavoriteSetting: selectedRadioStation.id) ? "star.fill" : "star")
                        .foregroundColor(showingStar || checkIsFavorite(myFavoriteSetting: selectedRadioStation.id) ? .yellow : .black)
                }
                
                
            }
            
            if isShowEq {
                LottieView(lottieFile: "music-equalizer")
                    .frame(width: 50, height: 50)
            }
            
            
            // Next programs
            newXMLSwiftUIView()
                .onAppear {
                    print("receivedURL \(receivedURL.theURL)")
                    print("the URL is \(selectedRadioStation.url)")
                }
            
            
            
            Button(action: {
                isPlaying.toggle()
                print("isPlaying \(isPlaying)")
                
                isShowEq = playRadio.playSongRadio(radioURL: selectedRadioStation.url, isPlaying: isPlaying)
                
            }) {
                
                
                if isPlaying {
                    Image("Pause2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    Image("But-Play2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                
            }
            
            .padding()
        }
        
        .frame(maxWidth: .infinity)
        
        .background(Color.newColorGreenLight)
        
        .navigationBarTitle("Radio \(selectedRadioStation.name)", displayMode: .inline)
        
        // new button back
        .navigationBarBackButtonHidden(true)
        
        .navigationBarItems(
            leading:
                // NavigationLink("Go to back", destination: SliderSwiftUIView())
            
            Button(action : {
                //player.replaceCurrentItem(with: nil)
                player.pause()
                self.presentationMode.wrappedValue.dismiss()
                print("click back and stop audio")
                print(checkIsFavorite(myFavoriteSetting: selectedRadioStation.id))
                print(selectedRadioStation.id)
                
                
            }){
                Text("Back").foregroundColor(.newSecundaryColor)
                Image(systemName: "arrow.uturn.backward")
                    .foregroundColor(.newSecundaryColor)
            }
        )
        .onAppear(perform: {
            receivedURL.theURL = selectedRadioStation.scheduleurl
            print("receivedURL.theURL \(receivedURL.theURL)")
            print("Favorites \(userSettings.favorite)")
            
        })
        
        .environmentObject(receivedURL)
        
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
    
    
    
    struct DetalleUIView_Previews: PreviewProvider {
        static var previews: some View {
            DetalleUIView(choice: "test", selectedRadioStation: radioStationInfo(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.",siteurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", url:"https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))
        }
    }
    
}

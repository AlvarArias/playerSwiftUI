//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI
import CachedAsyncImage


struct HomeRadioView: View {

    @AppStorage("username") private var theUserName = ""
    @AppStorage("ringtone") private var theFirstRadio = ""

    // Use decode helper
   // @State var radioStations: [radioStationInfo] = Bundle.main.decode([radioStationInfo].self, from: "radios23.json")

    @State var radioStations: [radioStationInfo] = []
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()

    
    @State private var items = 0...51

    @State private var showingFavorite = false
    @State private var showingmySettings = false
    @State private var showingmySearch = false
    @State private var isVStackVisible = false
    @State private var showingStar = false
    
    @State var isFavorite: Bool = false

    let textSelect = "Välj din radio"
    
    var checkIfIsFavorite = checkFavoriteC()
    @State private var isFavorieTest = false

    var body: some View {
               
        NavigationView {
        
            VStack {
                
                Text(theUserName)
                
                TabView {
                    switch theFirstRadio {
                    case "P2":
                        NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStations[1])) {
                            Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStations[2])) {
                            Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStations[0])) {
                            Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                    case "P3":
                        NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStations[2])) {
                            Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStations[0])) {
                            Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStations[1])) {
                            Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                    default:
                        NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square" , imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter och aktualiteter, granskning och fördjupning men också livsåskådnings-och livsstilsprogram samt underhållning och upplevelser till exempel i form av teater.", siteurl: "https://sverigesradio.se/p1", url: "http://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))) {
                            Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/163/2186754_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/163/2186754_512_512.jpg", color: "ff5a00", tagline: "P2 är den klassiska musikkanalen som även erbjuder jazz samt folk- och världsmusik. Digitalt sänder vi musikprogram dygnet runt, i FM finns även program på andra språk än svenska.", siteurl: "https://sverigesradio.se/p2", url: "http://sverigesradio.se/topsy/direkt/srapi/163.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=163", xmltvid:  "p2.sr.se", name: "P2", id: "163"))) {
                            Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/164/2186756_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/164/2186756_512_512.jpg", color: "19a972", tagline: "Kanalen för dig som gillar ny musik, livesänd radio och högkvalitativa poddar. Lyssna på P3 för populärkultur, samhällsjournalistik, musik och humor.", siteurl: "https://sverigesradio.se/p3", url: "http://sverigesradio.se/topsy/direkt/srapi/164.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=164", xmltvid: "p3.sr.se", name: "P3", id: "164"))) {
                            Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                    }
                }
                .tabViewStyle(.page)
                .background(Color.newColorGreenLight)
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .opacity(isVStackVisible ? 1.0 : 0.0)
                .animation(.easeIn(duration: 1.5), value: isVStackVisible)
                .onAppear {
                    withAnimation {
                        isVStackVisible = true
                    }
                }
                
         
                
                HStack {
                    Text(textSelect).padding()
                        .accessibilityLabel(textSelect)
                    CheckNetworkView()
                }
                
                // TODO: Add more radio Station
                // FIXME: Show favorites and impleent this in the view
                if radioStations.count > 0 {
                    ScrollView {
                        ForEach(items, id: \.self) { index in
                            LazyVStack{
                                LazyHStack {
                                    CachedAsyncImage(url: URL(string: radioStations[index].image), content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                    }, placeholder: {
                                        ProgressView()
                                    })
                                    Text(radioStations[index].tagline)
                                        .font(.caption)
                                        .lineLimit(3)
                                        .frame(width: 200)
                                    
                                    //arreglar al compportamiento
                                    /*
                                     favoriteButtonView(isFavorite: $isFavorite, selectedRadioStationId: radioStations[index].id)
                                     */
                                    /*
                                     if checkIsFavorite2(myFavoriteSetting: radioStations[index].id) {
                                     Image(systemName: "star.fill")
                                     .foregroundColor(.yellow)
                                     } else {
                                     Image(systemName: "star")
                                     
                                     }
                                     */
                                    
                                    /*
                                    Image(systemName: checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? "star.fill" : "star")
                                        .foregroundColor(checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? .yellow : .none)
                                    */
                                    
                                    Image(systemName: checkIfIsFavorite.manageData(data: radioStations[index].id, userSettings: userSettings) ? "star.fill" : "star")
                                        .foregroundColor(checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? .yellow : .none)
                                    
                                    Image(systemName: isFavorieTest ? "star.fill" : "star")
                                        .foregroundColor(checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? .yellow : .none)
                                        .onAppear{
                                            isFavorieTest = checkIfIsFavorite.manageData(data: radioStations[index].id, userSettings: userSettings)
                                            print("is Favorite value isFavorite test = \(isFavorieTest)")
                                        }
                                    
                                    
                                    Spacer()
                                    NavigationLink(destination: DetalleUIView(choice: radioStations[index].siteurl, selectedRadioStation: radioStations[index])) {
                                        Image(systemName: "arrow.forward.circle")
                                            .foregroundColor(Color.black.opacity(0.85))
                                    }
                                    .accessibilityValue(radioStations[index].id)
                                }
                                .padding(15)
                                .shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                                .background(Color.newPrimaryColor)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                
                            }
                            .opacity(isVStackVisible ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 1.5), value: isVStackVisible)
                            .onAppear {
                                withAnimation {
                                    isVStackVisible = true
                                }
                            }
                            
                        }
                        .navigationBarTitle("Radio App", displayMode: .inline)
                    }
                }
            }
            .onAppear {
                        if radioStations.isEmpty {
                            loadRadioStations()
                        }
                    }
            
            .background(Color.newColorGreenLight)
  
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        showingmySettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(Color.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingmySettings) {
                        newSettingsView()
                    }
                    
                    Spacer()
                    
                    Button {
                        showingFavorite.toggle()
                    } label: {
                        Image(systemName: "star")
                            .foregroundColor(.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingFavorite) {
                        FavoriteDispView()
                    }
                    
                    Spacer()
                    
                    
                    Button {
                        showingmySearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundColor(.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingmySearch) {
                        SerachView()
                    }
                    
  
                }
            }
        }
    }
    
    func checkIsFavorite2(myFavoriteSetting: String) ->Bool {
        
        if (userSettings.favorite.contains(myFavoriteSetting)) {
            
                return true
                    
                } else {
                   
                  return false
                }
            }
        
    
    func loadRadioStations() {
            guard let url = Bundle.main.url(forResource: "radios23", withExtension: "json") else {
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                radioStations = try decoder.decode([radioStationInfo].self, from: data)
            } catch {
                print("Error loading radio stations: \(error)")
            }
        }
    
    
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRadioView()
    }
}




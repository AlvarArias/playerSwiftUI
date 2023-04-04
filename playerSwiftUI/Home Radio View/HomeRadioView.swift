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
    @State var radioStations: [radioStationInfo] = Bundle.main.decode([radioStationInfo].self, from: "radios23.json")

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

    var body: some View {
               
        NavigationView {
        
            VStack {
                
                Text(theUserName)
                /*
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
                        NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStations[0])) {
                            Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStations[1])) {
                            Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStations[2])) {
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
                */
         
                
                HStack {
                    Text(textSelect).padding()
                        .accessibilityLabel(textSelect)
                    CheckNetworkView()
                }
                
                // TODO: Add more radio Station
                // FIXME: Show favorites and impleent this in the view
                
                ScrollView {
                    ForEach(items, id: \.self) { index in
                        VStack{
                            HStack {
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
                            
                                
                                Image(systemName: checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? "star.fill" : "star")
                                    .foregroundColor(checkIsFavorite2(myFavoriteSetting: radioStations[index].id) ? .yellow : .none)

                                 
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
        
    
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRadioView()
    }
}




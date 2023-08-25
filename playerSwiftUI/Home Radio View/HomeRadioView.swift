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

    @State var radioStations: [radioStationInfo] = []
    @State private var items = 0...51
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()

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
                
                // New tab view
                NewTabView()
                
                HStack {
                    Text(textSelect).padding()
                        .accessibilityLabel(textSelect)
                    CheckNetworkView()
                }
                
                
                // New list View
                NewListView()
                
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
    
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRadioView()
    }
}




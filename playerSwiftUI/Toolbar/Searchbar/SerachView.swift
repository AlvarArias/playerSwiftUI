//
//  SerachView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-18.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct SerachView: View {
    
    @State private var searchText=""
    
    @State var radioStations: [radioStationInfo] = []
    @State var items = 0...51
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()

    // Check if is favorite
    var checkIfIsFavorite = checkFavoriteC()
    
    // Load Stations
    var mYradioStation = LoadRadioStationJSONFile()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        var searchResults: [radioStationInfo] {
            if searchText.isEmpty {
                return radioStations
            } else {
                return radioStations.filter { word in
                    word.tagline.contains(searchText)
            }
        }
    }
        
        NavigationView {
            VStack {
                 
                List {
                    ForEach(searchResults, id: \.self) { name in
                       
                        HStack {
                          
                            CachedAsyncImage (url: URL(string: name.image), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            },
                            placeholder: {
                                ProgressView()
                            })
                            
                            
                            Text(name.tagline).font(.body).lineLimit(3)
                                .frame(width: 200)
                                .font(.body)
                            
                            Spacer()
                            
                            Image(systemName: checkIfIsFavorite.manageData(data: name.id, userSettings: userSettings) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                            
                          
                            NavigationLink(destination: DetalleUIView(choice: name.siteurl, selectedRadioStation: name)) {
                                
                                Text("")
                            }
                            
                           
                        } .listRowSeparator(.hidden)
                           
                    }
                    .navigationBarTitle("Sök", displayMode: .inline)
                }
                .background(Color.newColorGrayLight)
                
                .searchable(text: $searchText,
                            placement: .navigationBarDrawer(displayMode: .always))
                
               }
                .onAppear {
               
                if radioStations.isEmpty {
                    radioStations = mYradioStation.loadStation()
                        }
                }
            
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                    Button { dismiss() } label: {
                        ArrowToolBarView()
                    }
                }
           }
        }
    }
  
 
}
    




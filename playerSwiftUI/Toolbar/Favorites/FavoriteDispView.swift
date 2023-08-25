//
//  FavoriteDispView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-31.
//
import Foundation
import SwiftUI
import CachedAsyncImage


struct FavoriteDispView: View {

    @State var radioStations: [radioStationInfo] = []
    @State private var items = 0...51
   
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    // Check if is favorite
    var checkIfIsFavorite = checkFavoriteC()
    
    // Load Stations
    var mYradioStation = LoadRadioStationJSONFile()
    
    @Environment(\.dismiss) var dismiss
      
    var body: some View {
        NavigationView {
            
            VStack {
                 
                List {

                    ForEach(radioStations, id: \.self) { name in
                    
                        if checkIfIsFavorite.manageData(data: name.id, userSettings: userSettings) {
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
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.black)
                          
                            Spacer()
       
                            Image(systemName: checkIfIsFavorite.manageData(data: name.id, userSettings: userSettings) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                
                            
                            
                            NavigationLink(destination: DetalleUIView(choice: name.siteurl, selectedRadioStation: name)) {
                                
                                Text("")
                            }
                        
                           
                        } .listRowSeparator(.hidden)
                        
                        }
                    }
                  
                    .navigationBarTitle("Favoriter", displayMode: .inline)
                }
                .background(Color.newColorGrayLight)
               }
            .onAppear {
               
                if radioStations.isEmpty {
                    radioStations = mYradioStation.loadStation()
                }
                
            }
            
                .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button { dismiss() } label: {
                               Image(systemName: "arrow.down")
                           .foregroundColor(.newSecundaryColor)
                    }

                    }
           }
                .navigationBarTitle("Favorites", displayMode: .inline)
            
        }
        
    }
           
        
}
    
struct FavoriteDispView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDispView()
    }
}



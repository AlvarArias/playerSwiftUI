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
    
    @State var items = 0...51
    @State var myRadioDemo: [radioStationInfo] = Bundle.main.decode([radioStationInfo].self, from: "radios23.json")
    
    @Environment(\.dismiss) var dismiss
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()

    
    // User default for favorites
    let defaults = UserDefaults.standard
    
    var body: some View {
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
                            // MARK: Favotite button out
                            /*
                            if checkIsFavorite(myRadioFavo: name.id) {
                                 Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                 
                            }
                            */
                           
                            if checkIsFavorite2(myFavoriteSetting: name.id) {
                                 Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                 
                            }
                            
                          
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
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button { dismiss() } label: {
                               Image(systemName: "arrow.down")
                            .foregroundColor(Color.newSecundaryColor)
                    }

                    }
           }
        }
    }
           var searchResults: [radioStationInfo] {
               if searchText.isEmpty {
                   return myRadioDemo
               } else {
                   return myRadioDemo.filter { word in
                       word.tagline.contains(searchText)
               }
               
              
           }
       }
    
    func checkIsFavorite(myRadioFavo:String) -> Bool{
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(favoriteSaved.self, from: savedPerson) {
   
                // Check value in array
                if loadedPerson.favoriteId.contains(where: {$0 == myRadioFavo}) {
                   // it exists, do something
               
                return true
                    
                } else {
                   //item could not be found
                    
                    return false
                }
            }
        }
        return false
    }
    
    
    func checkIsFavorite2(myFavoriteSetting: String) ->Bool {
        
        if (userSettings.favorite.contains(myFavoriteSetting)) {
            
                return true
                    
                } else {
                   
                  return false
                }
            }
        
    

}
    
/*
struct SerachView_Previews: PreviewProvider {
    static var previews: some View {
        SerachView()
    }
}
*/
    
    
/*
 AsyncImage(url: URL(string: name.image), content: { image in
     image.resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: 50, height: 50)
 },
 placeholder: {
     ProgressView()
 })
 */




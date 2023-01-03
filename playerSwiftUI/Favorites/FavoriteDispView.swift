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
    
    @State private var searchText="163"
    
    @State private var items = 0...51
    @State private var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")
    
    @Environment(\.dismiss) var dismiss
    
    // User default for favorites
    let defaults = UserDefaults.standard
  
    
    var body: some View {
        NavigationView {
            
            VStack {
                 
                List {
                
                    
                    ForEach(myRadioDemo, id: \.self) { name in
                    
                        if checkIsFavorite(myRadioFavo: name.id) {
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
                            if checkIsFavorite(myRadioFavo: name.id) {
                                Image(systemName: "star.fill")
                                   .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                            }
                            
                            
                            NavigationLink(destination: DetalleUIView(choice: name.siteurl, choice1: name)) {
                                
                                Text("")
                            }
                        
                           
                        } .listRowSeparator(.hidden)
                        
                        }
                    }
                  
                    .navigationBarTitle("Radio App Favorites", displayMode: .inline)
                }
                
               }
                .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button { dismiss() } label: {
                               Image(systemName: "arrow.down")
                           // .foregroundColor(.newSecundaryColor)
                    }

                    }
           }
                .navigationBarTitle("Favorites", displayMode: .inline)
            
        }
        
    }
           
    
    func checkIsFavorite(myRadioFavo:String) ->Bool {
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
               
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                   // it exists, do something
                 
                return true
                    
                } else {
                   //item could not be found
                    //print("Radio \(myRadioFavo) is not Favorite")
                    
                    return false
                }
            }
        }
        return false
    }

}
    
struct FavoriteDispView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDispView()
    }
}

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

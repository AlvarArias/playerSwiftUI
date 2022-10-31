//
//  FavoritesView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-10-30.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<Favorite>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        predicate: NSPredicate(format: "name == %@", "P2")
    ) var radioNames: FetchedResults<Favorite>
    
    var body: some View {
        VStack {
            List(favorites) { favorite in
                Text(favorite.id ?? "Unknown")
                Text(favorite.image ?? "Unknown")
                Text(favorite.isFavorite.description)
                Text(favorite.name ?? "Unknown")
                Text(favorite.scheduleurl ?? "Unknown")
                Text(favorite.tagline ?? "Unknown")
                Text(favorite.url ?? "Unknown")
                
            }

            
            List(radioNames) { radioname in
                Text(radioname.name ?? "Unknown").foregroundColor(Color.cyan)
                }
            .onAppear {
                print(radioNames.count)
                checkIfExist()
            }
        }
    }
    
    func checkIfExist() {
        if (radioNames.count > 0) {
            print("true")
        } else {
            print("false")
        }
        
    }
    
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

//
//  favoriteButtonView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import SwiftUI

struct favoriteButtonView: View {
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    @State var showingStar = false
    
    @Binding var isFavorite: Bool
    
    // Radio Object
    @StateObject var receivedURL = theURLSetting()
    
    let selectedRadioStationId: String
    
    var body: some View {
        Button {
            isFavorite.toggle()
            
            if userSettings.favorite.contains(selectedRadioStationId) {
                deleteFavorite(delFavorite: selectedRadioStationId)
            } else {
                userSettings.favorite.append(selectedRadioStationId)
                
            }
            
            //receivedURL.isFavorite = isFavorite
            
        } label: {
            Image(systemName: isFavorite || checkIsFavorite(myFavoriteSetting: selectedRadioStationId) ? "star.fill" : "star")
                .foregroundColor(isFavorite || checkIsFavorite(myFavoriteSetting: selectedRadioStationId) ? .yellow : .black)
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


struct favoriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        favoriteButtonView(isFavorite: .constant(false), selectedRadioStationId: "14")
    }
}

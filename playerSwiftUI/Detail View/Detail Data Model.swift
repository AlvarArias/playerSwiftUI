//
//  Detail Data Model.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-03-29.
//

import Foundation
import SwiftUI


struct Person : Decodable,Encodable, Hashable {
    var mytest : [String]
    
    
    
    
}


class theURLSetting : ObservableObject {
    @Published var theURL: String = ""
    @Published var isFavorite : Bool = false
}





/*
func saveData(myData: Person) {
    print("saveData(myData: Person)")
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(myData) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "SavedPerson")
        print("End saveData(myData: Person)")
    }
}
*/

/*
 func saveData2() {
     // funcion que se ejecute una sola vez
     if controlFunc {
         
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(myData) {
             let defaults = UserDefaults.standard
             defaults.set(encoded, forKey: "SavedPerson")
             print("End saveData(myData: Person)")
             print(defaults.stringArray(forKey: "SavedPerson") ?? "No value added")
         
             controlFunc = false
         }
     }
 }
 */
 
 
/*
Button( action: {
   
   player = AVPlayer(url: URL(string: choice1.url)!)
   self.isPlaying.toggle()
   player.play()
   isShowEq = true

   if isPlaying == false {
       player.pause()
       isShowEq = false
   }
 
})
{
   if isPlaying == true {
       Image("Pause2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
       
   } else {
       Image("But-Play2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
       }
   }
  */

/*
  // Detail Image
  AsyncImage(url: URL(string: choice1.image), content: { image in
      image.resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 200, height: 200)
  },
  placeholder: {
      ProgressView()
          .frame(width: 50, height: 50)
  })
  .background(Color.red)
*/

// Barra inferior
 /*
 .toolbar {
         ToolbarItemGroup(placement: .bottomBar) {
 
     Button {
         isPlaying.toggle()
         print("isPlaying \(isPlaying)")
         testPlay()
         
       
     } label: {
         
         if isPlaying {
             //Image("Pause2").resizable().aspectRatio(contentMode: .fit)
               //  .frame(width: 50, height: 50)
             Image(systemName: "pause.circle.fill")
         }
         else {
             //Image("But-Play2").resizable().aspectRatio(contentMode: .fit)
               //  .frame(width: 50, height: 50)
             Image(systemName: "play.circle")
             }
         }
    
             Button { print("showingmySettings.toggle()")
                                         } label: {
                                             Image(systemName: "gearshape")
                                                 //.foregroundColor(Color.newPrimaryColor)
                                         }
             //.sheet(isPresented: $showingmySettings) {
               
                 //newSettingsView()
            // }
             
         }
 
 }
 */
         
 

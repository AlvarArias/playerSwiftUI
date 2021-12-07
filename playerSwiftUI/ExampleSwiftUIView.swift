//
//  ExampleSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2021-12-07.
//

import SwiftUI
import CoreMedia
//import AVKit
//import AVFoundation


struct myRadio {
    let radioURL : String
    let chanelID : String
    let radioName : String
    let radioLogoName : String
  
   
    /*
     //let url2  = URL.init(string:"https://sverigesradio.se/topsy/direkt/srapi/2562.mp3")
    <channel id="213" name="P4 Blekinge">
    <channel id="223" name="P4 Dalarna">
    <channel id="205" name="P4 Gotland">
    
    
     <channel id="132" name="P1">
     https://api.sr.se/api/v2/channels/132
     http://sverigesradio.se/topsy/direkt/srapi/132.mp3

     <channel id="163" name="P2">
     https://api.sr.se/api/v2/channels/163
     https://sverigesradio.se/topsy/direkt/srapi/2562.mp3

     <channel id="164" name="P3">
     https://api.sr.se/api/v2/channels/164
     https://sverigesradio.se/topsy/direkt/srapi/164.mp3
     
     */
}

struct ExampleSwiftUIView: View {
   
    @State var isPlaying : Bool = false
    
   
    
    var myPlayer = playerConector()
    
    var myRadioNow = [myRadio(radioURL: "132", chanelID: "132", radioName: "P1", radioLogoName: "P1"), myRadio(radioURL: "2562", chanelID: "132", radioName: "P2", radioLogoName: "P2"), myRadio(radioURL: "164", chanelID: "164", radioName: "P3", radioLogoName: "P3")]
    
    
    let rows = [GridItem(.fixed(50))]
    
    let items = 1...3
    
    
           var body: some View {
               
               ScrollView(.horizontal) {
                   LazyHGrid(rows: rows, alignment: .top) {
                       ForEach(items, id: \.self) { myIitem in
                           let localIndex = myIitem - 1
                           VStack {
                               Text(String(localIndex))
                               Text(myRadioNow[localIndex].radioName)
                               Image(myRadioNow[localIndex].radioLogoName).resizable().aspectRatio(contentMode: .fit).frame(width: 250, height: 200)
                               
                               Button(action: {
                                 
                                   let theURL = "https://sverigesradio.se/topsy/direkt/srapi/" + myRadioNow[localIndex].radioURL+".mp3"
                                   print(theURL)
                                   let theFinalURL = URL.init(string: theURL)
                                   
                                   myPlayer.play_radio(url: theFinalURL!)
                                   
                                self.isPlaying.toggle()
                                  
                               }) {
                                   Image(self.isPlaying == true ? "icon_pause" : "icon 5").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
            
                               }.padding(.top)
                               
                           }
                        
                           
                       }
                   }
                   .frame(height: 450)
               }
           }
       }
  

struct ExampleSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleSwiftUIView()
    }
}

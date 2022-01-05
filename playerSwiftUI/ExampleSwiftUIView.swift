//
//  ExampleSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2021-12-07.
//

import SwiftUI
import CoreMedia


struct ExampleSwiftUIView: View {
    
    @State var isPlaying : Bool = false
    
    var myPlayer = playerConector()
    
    var myRadioNow = [myRadio(radioURL: "132", chanelID: "132", radioName: "P1", radioLogoName: "P1"), myRadio(radioURL: "2562", chanelID: "132", radioName: "P2", radioLogoName: "P2"), myRadio(radioURL: "164", chanelID: "164", radioName: "P3", radioLogoName: "P3")]
    
    @State var tempURL : String = ""
    
    let rows = [GridItem(.fixed(10))]
    
    let items = 1...3
    
           var body: some View {
               NavigationView {
               VStack {
                   ScrollView(.horizontal) {
                       LazyHGrid(rows: rows, alignment: .top) {
                           ForEach(items, id: \.self) { myIitem in
                               let localIndex = myIitem - 1
                               VStack {
                                   Text(String(localIndex))
                                   Text(myRadioNow[localIndex].radioName)
                                   Image(myRadioNow[localIndex].radioLogoName).resizable().aspectRatio(contentMode: .fit).frame(width: 250, height: 200).onTapGesture{
                                       
                                       print(myRadioNow[localIndex].radioURL)
                                   }
                               }.padding()
                           }
                       }
                       .frame(height: 350)
                   }.background(Color.newPrimaryColor)
                
                   FavoritesSwiftUIView()
                   
               }.navigationBarTitle("Home Radio").background(Color.newSecundaryColor)
               }
        }
}

struct ExampleSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleSwiftUIView()
    }
}

extension Color {
    //static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("Verde")
    static let newSecundaryColor = Color("Cafe 1")
    static let newTerciaryColor = Color("Cafe 2")
    
}

/*
Button(action: {
  
    let theURL = "https://sverigesradio.se/topsy/direkt/srapi/" + myRadioNow[localIndex].radioURL+".mp3"
    print(theURL)
    let theFinalURL = URL.init(string: theURL)
    
    myPlayer.play_radio(url: theFinalURL!)
    
 self.isPlaying.toggle()
    
}) {
    
    Image(self.isPlaying == true ? "icon_pause" : "icon 5").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)

}.padding(.top) */

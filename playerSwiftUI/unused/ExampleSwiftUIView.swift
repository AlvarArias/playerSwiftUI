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
    @State var isSelect : Bool = false
    
    @StateObject var user = User()
    
    var myPlayer = playerConector()
    
    var myRadioNow = [myRadio(radioURL: "132", chanelID: "132", radioName: "P1", radioLogoName: "P1"), myRadio(radioURL: "2562", chanelID: "132", radioName: "P2", radioLogoName: "P2"), myRadio(radioURL: "164", chanelID: "164", radioName: "P3", radioLogoName: "P3")]
    
    @State var tempURL : String = ""
    
    let rows = [GridItem(.fixed(10))]
    
    let items = 0...2

    // Test data JSON
    // let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    
      let myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios.json")

    
           var body: some View {
               NavigationView {
               
                VStack {
                    
                    ScrollView {
                    
                   ScrollView(.horizontal) {
                    
                       LazyHGrid(rows: rows, alignment: .top) {
                        
                       ForEach(items, id: \.self) { index in

                               VStack {
                                   
                                   Text(String(index))
                                   Text(myRadioNow[index].radioName)
                                   
                                   Image(myRadioNow[index].radioLogoName).resizable().aspectRatio(contentMode: .fit).onTapGesture{

                                       isSelect.toggle()
                                       print(myRadioNow[index].radioURL)
                                       print("user.score\(user.score)")
                                       user.score += 1
                                       print(user.score)
                                       //print(" siteurl: \(myRadioDemo[0].siteurl) \(myRadioDemo.count)")
                                   }
                                   
                               }.padding()
                               NavigationLink("", destination: DetailSwiftUIView(myRadioNowD: myRadioNow, localIndexD: index), isActive: $isSelect)
                        
                            }
                       }
                       .frame(height: 350)

                       
                   }.background(Color.newPrimaryColor)
                

                        
                   //RadiosSwiftUIView()
                   
                   //FavoritesSwiftUIView()
                   
               }.navigationBarTitle("Home Radio").background(Color.newSecundaryColor)
                       .navigationBarTitleDisplayMode(.inline)
                   
                }.environmentObject(user)
                       
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
    static let newColorGrayLight = Color("Gris light")
    static let newColorGreenLight = Color("Verde light")
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

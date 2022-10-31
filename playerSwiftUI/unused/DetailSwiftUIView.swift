//
//  DetailSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct DetailSwiftUIView: View {
    
    @State private var showDetails = false
   
    var myRadioNowD : [myRadio]
    var localIndexD: Int
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
             Color.newPrimaryColor.edgesIgnoringSafeArea(.all)
            
            VStack {
            Text(myRadioNowD[localIndexD].radioName)
            Image(uiImage: UIImage(named: myRadioNowD[localIndexD].radioLogoName)!).resizable().aspectRatio(contentMode: .fit).padding()
            
                //Image(myRadioNowD[localIndexD].radioLogoName).resizable().aspectRatio(contentMode: .fit).frame(width: 250, height: 200).padding()
                
            InfoRadioSwiftUIView ()
            
            Button(action: {
                      print("button pressed")
                    print(myRadioNowD[localIndexD].radioName)

                    }) {
                        Image("Pause2")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
            
            
            }.navigationTitle("Radio detail").padding()
                
            
        }
    }
}
}

struct DetailSwiftUIView_Previews: PreviewProvider {
   
 static var previews: some View {
     
     let theRadio = [myRadio(radioURL: "132", chanelID: "132", radioName: "P1", radioLogoName: "P1"), myRadio(radioURL: "2562", chanelID: "132", radioName: "P2", radioLogoName: "P2"), myRadio(radioURL: "164", chanelID: "164", radioName: "P3", radioLogoName: "P3")]
     
     
        DetailSwiftUIView(myRadioNowD: theRadio, localIndexD: 0)
    }
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


/* ZStack {
 Color.newSecundaryColor.edgesIgnoringSafeArea(.all)
 }
 */

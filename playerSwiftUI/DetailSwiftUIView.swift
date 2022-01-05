//
//  DetailSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct DetailSwiftUIView: View {
    
    @State private var showDetails = false
    
    var body: some View {
        NavigationView {
            ZStack {
             Color.newPrimaryColor.edgesIgnoringSafeArea(.all)
            
        VStack {
            
            Image(uiImage: UIImage(named: "miRadio")!).resizable().aspectRatio(contentMode: .fit).padding()
            
            InfoRadioSwiftUIView ()
            
            Button(action: {
                      print("button pressed")

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
        DetailSwiftUIView()
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

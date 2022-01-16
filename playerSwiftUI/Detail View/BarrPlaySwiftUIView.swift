//
//  BarrPlaySwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-15.
//

import SwiftUI
import AVKit


struct BarrPlaySwiftUIView: View {
    
    @State var player = AVPlayer()
    
    let url1  = "https://sverigesradio.se/topsy/direkt/srapi/2562.mp3"

    @State var isPlaying : Bool = false
    
    var body: some View {
        
        Button( action: {
            
            player = AVPlayer(url: URL(string: url1)!)
            
            self.isPlaying.toggle()
         
            player.play()
            
            if isPlaying == false {
                player.pause()
            }
            
        })
        
        {
            if self.isPlaying == true {
                
                Image("icon_pause").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                
            } else {
                Image("icon 5").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
            }
        }.background(Color.red)
    }
}
struct BarrPlaySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BarrPlaySwiftUIView()
    }
}

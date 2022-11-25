//
//  ContentView.swift
//  PlayerAppleTV
//
//  Created by Alvar Arias on 2022-11-21.
//

import SwiftUI
import AVKit



struct ContentView: View {
    
    private let player = AVPlayer(url: (URL(string: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3") ?? URL(string: "https://api.sr.se/v2/scheduledepisodes?channelid=163"))!)
    
    
    
    var body: some View {
    
        /*
            VideoPlayer(player: player)
            .frame(width: 150, height: 150)
            .background(Color.cyan)
            .onAppear() {
                player.play()
            }
         */
        VStack {
           
        TVSliderView()
            
        HStack {
            Button {
                print("SVT 1")
                player.play()
                
            } label: {
                Text("SVT 1")
            }
            Button {
                print("SVT 2")
            } label: {
                Text("SVT 2")
            }
            
            Button {
                print("SVT 3")
            } label: {
                Text("SVT 3")
            }
            
        }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

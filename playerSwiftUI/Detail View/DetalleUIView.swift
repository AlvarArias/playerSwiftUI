//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import AVKit

struct DetalleUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var choice: String
    var choice1 : DemoRadio
    
    // Player variables
    @State var player = AVPlayer()
    let url1  = "https://sverigesradio.se/topsy/direkt/srapi/2562.mp3"
    @State var isPlaying : Bool = false
    @State var volum : Float = 0
    @State var sliderValue: Double = 0
    //@State var Myplayer = playerConector()
        
    var body: some View {
        
        let url = URL(string: choice1.image)
        
        
        NavigationView {
            
            
            VStack {
            
            //Image("P1").resizable().frame(width: 300, height: 300)
            AsyncImage(url: URL(string: choice1.image), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                     .frame(width: 200, height: 200)
            },
            placeholder: {
                ProgressView()
            })
        
            Text("Your Choice is \(choice)")
            
                
            List {
                Text(choice1.tagline).listRowBackground(Color.newSecundaryColor)
                Text(choice1.imagetemplate).listRowBackground(Color.newSecundaryColor)
                Text(choice1.scheduleurl).listRowBackground(Color.newSecundaryColor)
                Text(choice1.imagetemplate).listRowBackground(Color.newSecundaryColor)
                //Text("User: \(user.score)")
                //Text("User: \(user2.image)")
                
            }.background(Color.newSecundaryColor)
            
            
            //BarrPlaySwiftUIView()
            Button( action: {
            
                player = AVPlayer(url: URL(string: choice1.url)!)
                self.isPlaying.toggle()
                player.play()
                
                
                if isPlaying == false {
                    player.pause()
                }
                
                //Myplayer.play_radio(url: (URL(string: choice1.url) ?? URL(string: url1))!)
    
            })
            {
                if isPlaying == true {
                    
                    Image("icon_pause").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                    //Slider(value: $sliderValue, in: 0...10)
                        //Slider(value: $Myplayer.player.volume, in: 0...10).padding()
                    //Text("Current slider value: \(sliderValue, specifier: "%.2f")")
                    
                    
                } else {
                    Image("icon 5").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                }
            }
                
            }.navigationBarTitle("Radio", displayMode: .inline)
                // new button back
                .navigationBarItems(
                    leading:
                    Button(action : {
                        player.pause()
                        self.presentationMode.wrappedValue.dismiss()
                        print("click and stop audio")
                    }){
                            Text("Back")
                    }
                )
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.", siteurl: "https://sverigesradio.se/p1", url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se"))
    }
}
/*
 DemoRadio(image: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.", siteurl: "https://sverigesradio.se/p1", url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se")
 
 */

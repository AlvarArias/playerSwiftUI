//
//  DetalleUIView.swift
//  playerSwiftUI2
//
//  Created by Alvar Arias on 2022-12-18.
//

import SwiftUI
import AVKit

struct DetalleUIView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var choice : String
    @State var choice1 : DemoRadio
    @State var isPlaying = false
    
    @State var player = AVPlayer()  
    
    var body: some View {
        
        VStack {
        
        
        Button( action: {
            
            player = AVPlayer(url: URL(string: choice1.url)!)
            self.isPlaying.toggle()
            player.play()
            //isShowEq = true
        
            if isPlaying == false {
                player.pause()
                //isShowEq = false
            }
            
            //TODO: Check backgroung sound is working and how to stop it See add Wiget for playing control
            // Function play in background
            
            /*
            do {
                try AVAudioSession.sharedInstance()
                                      .setCategory(AVAudioSession.Category.playback)
                print("AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                    print("AVAudioSession is Active")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            */
    
        })
        {
            if isPlaying == true {
                Image("Pause2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                
            } else {
                Image("But-Play2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
            }
        }
            
        }.navigationBarTitle("Radio \(choice1.name)", displayMode: .inline)
            // new button back
        
            .navigationBarItems(
                leading:
                   // NavigationLink("Go to back", destination: SliderSwiftUIView())
                
                Button(action : {
                    
                    player.pause()
                    self.presentationMode.wrappedValue.dismiss()
                    print("click and stop audio")
                }){
                        //Text("Back").foregroundColor(.newSecundaryColor)
                    Image(systemName: "arrow.uturn.backward")
                        .foregroundColor(.newSecundaryColor)
                    
                    
                }
            
            ).background(Color.newColorGreenLight)
    
            .navigationBarBackButtonHidden(true)
    

    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "choice", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.",siteurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", url:"https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))
    }
}

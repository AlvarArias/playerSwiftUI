//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import AVKit

class theURLSetting : ObservableObject {
    @Published var theURL: String = ""
}

struct DetalleUIView : View {
    
    @Environment(\.presentationMode) var presentationMode

    /*init(){
            UITableView.appearance().backgroundColor = .clear
        }*/
    
    @StateObject var receivedURL = theURLSetting()
    
    var choice: String
    @State var choice1 : DemoRadio
    
    
    
    // Player variables
    @State var player = AVPlayer()
    let url1  = "https://sverigesradio.se/topsy/direkt/srapi/2562.mp3"
    @State var isPlaying : Bool = false
    @State var volum : Float = 0
    @State var sliderValue: Double = 0

        
    var body: some View {
        
        let url = URL(string: choice1.image)
    
        NavigationView {
        
            VStack {
            
            AsyncImage(url: URL(string: choice1.image), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                     .frame(width: 200, height: 200)
            },
            placeholder: {
                ProgressView()
            })
        
                Text("Next programs")
            
                newXMLSwiftUIView()
            
            //BarrPlaySwiftUIView()
            Button( action: {
            
                player = AVPlayer(url: URL(string: choice1.url)!)
                self.isPlaying.toggle()
                player.play()
                
                
                if isPlaying == false {
                    player.pause()
                }
                
    
            })
            {
                if isPlaying == true {
                    
                    Image("icon_pause").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
            
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
                ).background(Color.newColorGreenLight)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            receivedURL.theURL = choice1.scheduleurl
            print(receivedURL.theURL)
        })
        .environmentObject(receivedURL)
    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.", siteurl: "https://sverigesradio.se/p1", url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se"))
    }
}

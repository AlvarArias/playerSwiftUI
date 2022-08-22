//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import AVKit
import Lottie

class theURLSetting : ObservableObject {
    @Published var theURL: String = ""
}

struct DetalleUIView : View {
    
    // Testing song view model
    @StateObject private var vm = SongViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    // Radio Object
    @StateObject var receivedURL = theURLSetting()
    var choice: String
    @State var choice1 : DemoRadio
    

    // Player variables
    @State var player = AVPlayer()
    let url1  = "https://sverigesradio.se/topsy/direkt/srapi/2562.mp3"
    @State var isPlaying : Bool = false
    @State var volum : Float = 0
    @State var sliderValue: Double = 0

    @State var showingStar = false
    @State var isShowEq = false
    
    // Binding
    //@Binding var isSet: Bool
    
    var body: some View {
        
        //let url = URL(string: choice1.image)
    
        NavigationView {
        
            VStack {
                
            // Detail Image
            AsyncImage(url: URL(string: choice1.image), content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                     .frame(width: 200, height: 200)
            },
            placeholder: {
                ProgressView()
            })
        
                HStack{
                    /*
                    if isShowEq {
                    LottieView(lottieFile: "music-equalizer")
                        .frame(width: 50, height: 50)
                    }
                    */
                    
                    Text("Next programs").padding()
                    /*
                    Button {
                                isSet.toggle()
                            } label: {
                                Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                                    .labelStyle(.iconOnly)
                                    .foregroundColor(isSet ? .yellow : .gray)
                            }
                    */
                    
                    Button {
                        showingStar.toggle()
                        print("Select Favorite")
                        //FIXME: Add Binding to favorites funtionallity
                        
                    
                        
                    } label: {
                        if showingStar {
                           Image(systemName: "star.fill" )
                                .foregroundColor(.newSecundaryColor)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.newSecundaryColor)
                        }
                    }
                    
                    
                }
                
                if isShowEq {
                LottieView(lottieFile: "music-equalizer")
                    .frame(width: 50, height: 50)
                }
                
                //TODO: Add song player now in other view
                // SongView Model and Sing Object Added
                // Testing Fech Song is working
                // Make dinamis the channel for the Url
                // Add the content to the Screen
                
                newXMLSwiftUIView()
            
            //BarrPlaySwiftUIView()
            
            //TODO: Make button play automatic when the view is load.
            Button( action: {
            
                player = AVPlayer(url: URL(string: choice1.url)!)
                self.isPlaying.toggle()
                player.play()
                isShowEq = true
                
                if isPlaying == false {
                    player.pause()
                    isShowEq = false
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
                
            }.navigationBarTitle("Radio", displayMode: .inline)
                // new button back
                .navigationBarItems(
                    leading:
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
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            receivedURL.theURL = choice1.scheduleurl
            print(receivedURL.theURL)
        })
        .environmentObject(receivedURL)
        
        .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error){
                Button(action: vm.fetchUsers){
                        Text("Retry")
                }
            }
    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.", siteurl: "https://sverigesradio.se/p1", url: "https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", isFavorite: false))
    }
}

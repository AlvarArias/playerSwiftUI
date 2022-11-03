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
    @Published var isFavorite : Bool = false
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
    @State private var isFavorite = false
    
    // Favorites
    //@StateObject var favorites = Favorites()
    @Binding var isNight : Bool
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    let defaults = UserDefaults.standard
    
    
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
                   
                   // nuevo boton
                    Button {
                        showingStar.toggle()
                        if showingStar {
            
                            saveNewData()
                            receivedURL.isFavorite = true
                            print("receivedURL.isFavorite \(receivedURL.isFavorite)")
                            userSettings.favorite = "test from view"
                            
                            isNight = true
                            print("is isNight from detail is favorite")
                            print(isNight)
                            
                        } else {
                          
                            deleteNewData()
                            receivedURL.isFavorite = false
                            
                            isNight = false
                            print("is isNight from detail not favorite")
                            print(isNight)
                        }
                        
                    } label: {
                        
                        if showingStar {
                           Image(systemName: "star.fill" )
                                .foregroundColor(.newSecundaryColor)
                        } else if checkIsFavorite(myRadioFavo: choice1.id) {
                           
                            Image(systemName: "star.fill" )
                                 .foregroundColor(.newSecundaryColor)
                            
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.newSecundaryColor)
                        }
                    }
                    .onAppear {
                        isNight = true
                        print("is isNight from detail from appear")
                        print(isNight)
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
        }
        .background(Color.newColorGreenLight)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            receivedURL.theURL = choice1.scheduleurl 
            print(receivedURL.theURL)
        })
        .environmentObject(receivedURL)
       
        /*
        .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error){
                Button(action: vm.fetchUsers){
                        Text("Retry")
                }
            }
         */
    }
    
    // Funciones Favorites
    func saveData(myData: Person) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(myData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }
    
    func saveNewData() {
       
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == choice1.id}) {
                   // it exists, do something
                   print("element exists")
                    
                 return
                    
                } else {
                   //item could not be found
                    let moreData = choice1.id
                    loadedPerson.mytest.append(moreData)
                    print("saveNewData()")
                    print(loadedPerson.mytest)
                    saveData(myData: loadedPerson)
                    print("new element added")
                }
            }
        } else { print("no data")}
        
    }
    
    func deleteNewData() {
     
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                //print(loadedPerson.name)
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == choice1.id}) {
                   // it exists, do something
                 print("Favorite exists")
                    let myIndex = loadedPerson.mytest.firstIndex(of: choice1.id)
                    print(myIndex!)
                 
                    loadedPerson.mytest.remove(at: myIndex!)
                    
                } else {
                   //item could not be found
                    print("elemento no existe")
                }
                
                print("deleteNewData()")
                print(loadedPerson.mytest)
                
                saveData(myData: loadedPerson)
                
            }
        } else { print("no data")}
    }
    
    
    func checkIsFavorite(myRadioFavo:String) ->Bool {
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print("loadedPerson.name")
                print(loadedPerson.mytest)
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                
                return true
                    
                } else {
    
                    return false
                }
            }
        }
        return false
    }
    
  
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.",siteurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", url:"https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"), isNight: .constant(false))
    }
}

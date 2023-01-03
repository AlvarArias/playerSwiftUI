//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI
import AVKit
import Lottie
import CachedAsyncImage

struct Person : Decodable,Encodable, Hashable {
    var mytest : [String]
}


class theURLSetting : ObservableObject {
    @Published var theURL: String = ""
    @Published var isFavorite : Bool = false
}

struct DetalleUIView : View {
        
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

    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    let defaults = UserDefaults.standard
    
    // Data user default
    var myData = Person(mytest: ["Alvar", "Joel"])
   
    
    @State var controlFunc = true
        
    
    var body: some View {
        
        NavigationView {
        
            ScrollView {
         
                CachedAsyncImage (url: URL(string: choice1.image), content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: 200, height: 200)
                },
                placeholder: {
                    ProgressView()
                })
                .frame(width: UIScreen.main.bounds.width, height: 200)
                //.background(Color.red)
                
                HStack{
                    Text("Next programs").padding()
                   
                    /*
                    Button {
                        print("savedPerson ")
                        let savedPerson = defaults.object(forKey: "SavedPerson")
                        print(savedPerson ?? "No value")
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    */
                    // MARK: Button start
                    Button {
                        showingStar.toggle()
                        if showingStar {
                            
                            saveNewData()
                            receivedURL.isFavorite = true
                            print("receivedURL.isFavorite \(receivedURL.isFavorite)")
                            userSettings.favorite = "test from view"
                            
                        } else {
                          
                            deleteNewData()
                            receivedURL.isFavorite = false
                            
                        }
                        
                    } label: {
                        
                        if showingStar {
                           Image(systemName: "star.fill" )
                                .foregroundColor(.yellow)
                        } else if checkIsFavorite(myRadioFavo: choice1.id) {
                           
                            Image(systemName: "star.fill" )
                                 .foregroundColor(.yellow)
                            
                        } else {
                            Image(systemName: "star")
                                //.foregroundColor(.newSecundaryColor)
                        }
                    }
                    
                }
                
                if isShowEq {
                LottieView(lottieFile: "music-equalizer")
                    .frame(width: 50, height: 50)
                }
                
                // Next programs
                newXMLSwiftUIView()
            
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
                            //.foregroundColor(.newSecundaryColor)
                    }
                      
                )
        
        .navigationBarBackButtonHidden(true)
    
        .environmentObject(receivedURL)
       
        .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
        
            Button {
                isPlaying.toggle()
                print("isPlaying \(isPlaying)")
                testPlay()
                
              
            } label: {
                
                if isPlaying {
                    //Image("Pause2").resizable().aspectRatio(contentMode: .fit)
                      //  .frame(width: 50, height: 50)
                    Image(systemName: "pause.circle.fill")
                }
                else {
                    //Image("But-Play2").resizable().aspectRatio(contentMode: .fit)
                      //  .frame(width: 50, height: 50)
                    Image(systemName: "play.circle")
                    }
                }
            .padding()
            //.background(Color.red)
            }
                
        }
        
        
    }

    // Funciones Favorites

    func saveData(myData: Person) {
        
        if controlFunc {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(myData) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedPerson")
                print("End saveData(myData: Person)")
                print(defaults.stringArray(forKey: "SavedPerson") ?? "No value encoded Save Data()")
            
                controlFunc = false
            }
        }
    }
    
    func saveNewData() {
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == choice1.id}) {
                   
                   print("element exists")
                    
                 //return
                    
                } else {
                   
                    let moreData = choice1.id
                    loadedPerson.mytest.append(moreData)
                    print("saveNewData()")
                    print(loadedPerson.mytest)
                    saveData(myData: loadedPerson)
                    print("new element added")
                }
            }
        } else { print("no data saveNewData()")}
        
    }
    
    func deleteNewData() {
     
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if var loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
               
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
        } else { print("no data deleteNewData()")}
    }
    
    
    func checkIsFavorite(myRadioFavo:String) ->Bool {
        
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                // Check value in array
                if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                print("is favorite")
                return true
                    
                } else {
                    
                  return false
                }
            }
        }
        return false
    }
    
    func testPlay(){
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(AVAudioSession.Category.playback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
                
                // func Play Now()
                player = AVPlayer(url: URL(string: choice1.url)!)
                player.play()
                isShowEq = true
                
                if isPlaying == false {
                    player.pause()
                    isShowEq = false
                }
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}


struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.",siteurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", url:"https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))
    }
}


/*
func saveData(myData: Person) {
    print("saveData(myData: Person)")
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(myData) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "SavedPerson")
        print("End saveData(myData: Person)")
    }
}
*/

/*
 func saveData2() {
     // funcion que se ejecute una sola vez
     if controlFunc {
         
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(myData) {
             let defaults = UserDefaults.standard
             defaults.set(encoded, forKey: "SavedPerson")
             print("End saveData(myData: Person)")
             print(defaults.stringArray(forKey: "SavedPerson") ?? "No value added")
         
             controlFunc = false
         }
     }
 }
 */
 
 
/*
Button( action: {
   
   player = AVPlayer(url: URL(string: choice1.url)!)
   self.isPlaying.toggle()
   player.play()
   isShowEq = true

   if isPlaying == false {
       player.pause()
       isShowEq = false
   }
 
})
{
   if isPlaying == true {
       Image("Pause2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
       
   } else {
       Image("But-Play2").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
       }
   }
  */

/*
  // Detail Image
  AsyncImage(url: URL(string: choice1.image), content: { image in
      image.resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 200, height: 200)
  },
  placeholder: {
      ProgressView()
          .frame(width: 50, height: 50)
  })
  .background(Color.red)
*/


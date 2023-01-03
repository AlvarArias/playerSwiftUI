//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI
import CachedAsyncImage

@available(iOS 15.0, *)
struct SliderSwiftUIView: View {
    

    @AppStorage("username") private var theUserName = ""
    @AppStorage("ringtone") private var theFirstRadio = ""
    
   
    
    
    // Usa decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")
    
    @State var items = 0...51
    
    @State private var showingFavorite = false
    @State private var showingmySettings = false
    @State private var showingmySearch = false
    //@State private var animationAmount = 1.0
    @State var numberOfShakes: CGFloat = 0
    @State private var isImageLoad = false
    
   
    // User default for favorites
    let defaults = UserDefaults.standard
    //@AppStorage("favorite") var theUserFavorite = ""
    @State private var newtest = Person(mytest: [""])
    @State private var isNew = false
    
    
    //@State var isNight = false
    
    @EnvironmentObject var receivedURL: theURLSetting
   
    
    var body: some View {
               
        NavigationView {
        
            VStack {
                
                Text(theUserName)
             
                TabView {
           
                    if theFirstRadio == "P2" {
                    
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2").accessibilityLabel("P2")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3").accessibilityLabel("P3")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                            Image("P1").accessibilityLabel("P1")
                        }
                        
                        
                    }
                    
                    else if theFirstRadio == "P3" {
                        
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                                Image("P1")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2")
                        }
                        
                    }
                    
                    else {
                    
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                    Image("P1")
            }
            
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                Image("P2")
            }
            
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                Image("P3")
            }
        
                    }
        
       
        }
                .tabViewStyle(.page)
                //.foregroundColor()
                //.background(Color.newColorGrayLight)
                
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .onAppear {
            //tarea cuando aparece
        }
                
                HStack {
                    Text("Select your radio").padding()
                        .accessibilityLabel("Select your radio")
                        
                    
                    CheckNetworkView()
                }
                
                // TODO: Add more radio Station
                // FIXME: Show favorites and impleent this in the view
              
                List {
                    ForEach(items, id: \.self) { index in
                    
                        HStack {
                            
                            CachedAsyncImage (url: URL(string: myRadioDemo[index].image), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            },
                            placeholder: {
                                ProgressView()
                            })
                            
                            
                            Text(myRadioDemo[index].tagline).font(.body).lineLimit(3)
                                .frame(width: 200)
                                .font(.body)
                          
                            Spacer()
                            
                            // MARK: add  binding variable for selected favorite from page
                            // if else binding change show the star fill
                            // apple tutorial
                            // MARK: Favorite start
                            /*
                            NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index], isNight: .constant(checkIsFavorite(myRadioFavo: myRadioDemo[index].id)))) {
                                
                                Text("")
                            }
                            */
                           
                        } .listRowSeparator(.hidden)
                        
                               }
                               .navigationBarTitle("Radio App", displayMode: .inline)
                    
                           }
                .onAppear {
                    print("is Night")
                   // print(isNight)
                
                   
                }
                .accessibilityLabel("ListOfRadios")
                
               
               //TODO: Add social shared funtionality
                

            }//.background(Color.newColorGrayLight)
                .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                    
                                                
                    Button { showingmySettings.toggle()
                                                } label: {
                                                    Image(systemName: "gearshape")
                                                        //.foregroundColor(Color.newPrimaryColor)
                                                }
                    .sheet(isPresented: $showingmySettings) {
                      
                        newSettingsView()
                    }
                   
                    // MARK: favorite menu Showing
                    
                    Spacer()
                    Button { showingFavorite.toggle()
                                                } label: {
                                                    Image(systemName: "star")
                    //.foregroundColor(.newSecundaryColor)
                                                    
                    .sheet(isPresented: $showingFavorite) {FavoriteDispView()}
                                                    
                                                }
                    
                    Spacer()
                    Button { showingmySearch.toggle()
                                            } label: {
                                                    Image(systemName: "magnifyingglass.circle")
                        //.foregroundColor(.newSecundaryColor)
                                            }
                    .sheet(isPresented: $showingmySearch) {SerachView()}
                    
                                }
                            }
            
            }
        }
        
        func checkIsFavorite(myRadioFavo:String) -> Bool{
            
            if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
                let decoder = JSONDecoder()
                if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                   
                    // lo hacemos igual a load person
                    newtest.mytest = loadedPerson.mytest
                    if newtest.mytest.contains(where: {$0 == myRadioFavo}) {
                     isNew = true
                    }
                    
                    // Check value in array
                    if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                       // it exists, do something
                     
                    return true
                        
                    } else {
                       //item could not be found
     
                        return false
                    }
                }
            }
            return false
            
                
        }
        
    
    
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
}


extension Color {
    static let newPrimaryColor = Color(red: 166, green: 207, blue: 202)
    static let newSecundaryColor = Color(red: 203, green: 137, blue: 135)
    static let newTerciaryColor = Color(red: 232, green: 142, blue: 130)
    static let newColorGrayLight = Color(red: 247, green: 247, blue: 247)
    static let newColorGreenLight = Color(red: 236, green: 248, blue: 246)
}





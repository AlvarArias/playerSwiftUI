//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI
import CachedAsyncImage

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
  
    
    var body: some View {
               
        NavigationView {
            
            VStack {
                
                Text(theUserName)
             
                TabView {
           
                    if theFirstRadio == "P2" {
                    
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                                Image("P1")
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
        .tabViewStyle(.page).foregroundColor(Color.newPrimaryColor)
        .background(Color.newColorGrayLight)
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .onAppear {
            //tarea cuando aparece
        }
                
                HStack {
                    Text("Select your radio").padding()
                        
                    
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
                            
                            if checkIsFavorite(myRadioFavo: myRadioDemo[index].id) {
                                 Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                 
                            }
                               
                            NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                                
                                Text("")
                            }
                            
                           
                        } .listRowSeparator(.hidden)
                        
                               }
                               .navigationBarTitle("Radio App", displayMode: .inline)
                    
                           }
                .onAppear {
                    print("list appear")
                   
                }
                
                
               //TODO: Add social shared funtionality
                
                /*
                VStack {
                    Text("Radio on line")
                    
                    Button(action: {
                        
                        print("Sharer")
                       
                        
                    }) {
                        Text("Sharer")
                    }
                }
                 */
                
               
            }.background(Color.newColorGrayLight)
                .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                    
                                                
                    Button { showingmySettings.toggle()
                                                } label: {
                                                    Image(systemName: "gearshape")
                    .foregroundColor(.newSecundaryColor)
                                                }
                    .sheet(isPresented: $showingmySettings) {
                      
                        newSettingsView()
                    }
                   
                    Spacer()
                    Button { showingFavorite.toggle()
                                                } label: {
                                                    Image(systemName: "star")
                    .foregroundColor(.newSecundaryColor)
                                                    
                    .sheet(isPresented: $showingFavorite) {FavoriteDispView()}
                                                    
                                                }
                    Spacer()
                    Button { showingmySearch.toggle()
                                            } label: {
                                                    Image(systemName: "magnifyingglass.circle")
                        .foregroundColor(.newSecundaryColor)
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
                    print("loadedPerson.name")
                    print(loadedPerson.mytest)
                    
                    // Check value in array
                    if loadedPerson.mytest.contains(where: {$0 == myRadioFavo}) {
                       // it exists, do something
                     //print("Radio \(myRadioFavo) is Favorite")
                     
                    return true
                        
                    } else {
                       //item could not be found
                        //print("Radio \(myRadioFavo) is not Favorite")
                        
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




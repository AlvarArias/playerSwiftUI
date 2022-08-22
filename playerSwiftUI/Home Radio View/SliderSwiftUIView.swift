//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI

struct SliderSwiftUIView: View {
    

    @AppStorage("username") private var theUserName = ""
    @AppStorage("ringtone") private var theFirstRadio = ""
    
    // Usa decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios.json")
    
    @State var items = 0...9
    
    @State private var showingFavorite = false
    @State private var showingmySettings = false
    @State private var showingmySearch = false
    //@State private var animationAmount = 1.0
    @State var numberOfShakes: CGFloat = 0
    @State private var isImageLoad = false
    
    
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
        
                
                HStack {
                    Text("Select your radio").padding()
                        
                    
                    CheckNetworkView()
                }
                
                // TODO: Add more radio Station
                // FIXME: Show favorites and impleent this in the view
                
                List {
                    ForEach(items, id: \.self) { index in
                    
                        HStack {
                            if (!isImageLoad) {
                                AsyncImage(url: URL(string: myRadioDemo[index].image), content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                },
                                placeholder: {
                                    ProgressView()
                                }).onAppear {
                                    isImageLoad = true
                                    print(" Image is load \(isImageLoad)")
                                }
                                
                            }
                            
                            AsyncImage(url: URL(string: myRadioDemo[index].image), content: { image in
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
                            
                            
                            if (myRadioDemo[index].isFavorite) {
                                            Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                        }
                            
                            
                            NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                                
                                Text("")
                            }
                            
                           
                        } .listRowSeparator(.hidden)
                        
                               }
                               .navigationBarTitle("Radio App", displayMode: .inline)
                    
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
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
    }
}



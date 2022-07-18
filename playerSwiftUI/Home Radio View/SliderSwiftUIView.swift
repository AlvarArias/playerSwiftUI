//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI

struct SliderSwiftUIView: View {
    
    // Usa decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios.json")
    
    @State var items = 0...9
    
    @State private var showingFavorite = false
    @State private var showingmySettings = false
  
    var body: some View {
               
        NavigationView {
            
            VStack {
                
                TabView {
            
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
        .tabViewStyle(.page).foregroundColor(Color.newPrimaryColor)
        .background(Color.newColorGrayLight)
        .frame(width: UIScreen.main.bounds.width, height: 300)
                
                HStack {
                    Text("Select your radio").padding()
                    CheckNetworkView()
                }
                
                
                
                List {
                    ForEach(items, id: \.self) { index in
                    
                        HStack {
                           
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
                          
                            NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                                
                                Text("")
                            }
                            
                           
                        } .listRowSeparator(.hidden)
                        
                               }
                               .navigationBarTitle("Radio App", displayMode: .inline)
                           }
               
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
                                                    Image(systemName: "gearshape")}
                    .sheet(isPresented: $showingmySettings) {mySettingsView()}
                   
                    Button { showingFavorite.toggle()
                                                } label: {
                                                    Image(systemName: "star")}
                        
                                }
                            }
                                
        }.onAppear(){ print(myRadioDemo[0])
                
    }

}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
    }
}



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

    // Use decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")

    @State private var items = 0...51

    @State private var showingFavorite = false
    @State private var showingmySettings = false
    @State private var showingmySearch = false


    let textSelect = "Välj din radio"

       
    var body: some View {
               
        NavigationView {
        
            VStack {
                
                Text(theUserName)
                
                TabView {
                    switch theFirstRadio {
                    case "P2":
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2").accessibilityLabel("P2")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3").accessibilityLabel("P3")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                            Image("P1").accessibilityLabel("P1")
                        }
                    case "P3":
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3").accessibilityLabel("P3")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                            Image("P1").accessibilityLabel("P1")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2").accessibilityLabel("P2")
                        }
                    default:
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                            Image("P1").accessibilityLabel("P1")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2").accessibilityLabel("P2")
                        }
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3").accessibilityLabel("P3")
                        }
                    }
                }
                
                .tabViewStyle(.page)
                .background(Color.newColorGrayLight)
                
                .frame(width: UIScreen.main.bounds.width, height: 300)
                
                
                HStack {
                    Text(textSelect).padding()
                        .accessibilityLabel(textSelect)
                    CheckNetworkView()
                }
                
                // TODO: Add more radio Station
                // FIXME: Show favorites and impleent this in the view
                
                ScrollView {
                    ForEach(items, id: \.self) { index in
                        VStack{
                            HStack {
                                CachedAsyncImage(url: URL(string: myRadioDemo[index].image), content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                }, placeholder: {
                                    ProgressView()
                                })
                                Text(myRadioDemo[index].tagline)
                                    .font(.caption)
                                    .lineLimit(3)
                                    .frame(width: 200)
                                Spacer()
                                NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                                    Image(systemName: "arrow.forward.circle")
                                        .foregroundColor(Color.black.opacity(0.85))
                                }
                                .accessibilityValue(myRadioDemo[index].id)
                            }
                            .padding(15)
                            .shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                            .background(Color.newPrimaryColor)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                        }
                        
                    }
                    .navigationBarTitle("Radio App", displayMode: .inline)
                }
                
            }
            .background(Color.newColorGreenLight)
  
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        showingmySettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(Color.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingmySettings) {
                        newSettingsView()
                    }
                    
                    Spacer()
                    
                    Button {
                        showingFavorite.toggle()
                    } label: {
                        Image(systemName: "star")
                            .foregroundColor(.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingFavorite) {
                        FavoriteDispView()
                    }
                    
                    Spacer()
                    
                    Button {
                        showingmySearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundColor(.newSecundaryColor)
                    }
                    .sheet(isPresented: $showingmySearch) {
                        SerachView()
                    }
                }
            }

            
            }
        }
        
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
}




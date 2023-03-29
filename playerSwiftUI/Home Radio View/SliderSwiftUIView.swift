//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI
import CachedAsyncImage

//@available(iOS 15.0, *)



struct SliderSwiftUIView: View {

    @EnvironmentObject var receivedURL: theURLSetting

    @AppStorage("username") private var theUserName = ""
    @AppStorage("ringtone") private var theFirstRadio = ""

    // Use decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")

    @State private var items = 0...51

    @State private var showingFavorite = false
    @State private var showingmySettings = false
    @State private var showingmySearch = false

    // User defaults for favorites
    let defaults = UserDefaults.standard
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
                 
                 
                 NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                 
                 Text("")
                 }.accessibilityValue(myRadioDemo[index].id)
                 
                 
                 } .listRowSeparator(.hidden)
                 
                 }
                 .navigationBarTitle("Radio App", displayMode: .inline)
                 
                 }
                 
                // Work more is this View
                /*
                ScrollView {
                ForEach(items, id: \.self) { index in
                    HStack {
                        CachedAsyncImage(url: URL(string: myRadioDemo[index].image), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        }, placeholder: {
                            ProgressView()
                        })
                        Text(myRadioDemo[index].tagline)
                            .font(.body)
                            .lineLimit(3)
                            .frame(width: 200)
                            .font(.body)
                        Spacer()
                        NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                            Text(">")
                        }
                        .accessibilityValue(myRadioDemo[index].id)
                    }
                    .listRowSeparator(.hidden)
                }
                .navigationBarTitle("Radio App", displayMode: .inline)
                
            }
                
                */
               //TODO: Add social shared funtionality
                

            }
            .background(Color.newColorGrayLight)
  
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
        
    /// Check if a radio station is saved as a favorite.
    ///
    /// - Parameters:
    ///   - myRadioFavo: The name of the radio station to check.
    ///
    /// - Returns: A Boolean value indicating whether the radio station is saved as a favorite.
    ///
    /// This function checks if a radio station is saved as a favorite in the app's saved data.
 
    func checkIsFavorite(myRadioFavo: String) -> Bool {
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                if loadedPerson.mytest.contains(where: { $0 == myRadioFavo }) {
                    return true
                } else {
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




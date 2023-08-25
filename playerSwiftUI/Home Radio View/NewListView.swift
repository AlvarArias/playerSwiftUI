//
//  NewListView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import SwiftUI
import CachedAsyncImage

struct NewListView: View {
    
    @State var radioStations: [radioStationInfo] = []
    @State private var items = 0...51
    
    // User default for favorites
    @ObservedObject var userSettings = UserSettings()
    
    // Check if is favorite
    var checkIfIsFavorite = checkFavoriteC()
    
    // Load Stations
    var mYradioStation = LoadRadioStationJSONFile()
    
    @State private var isVStackVisible = false
    
    var body: some View {
        VStack {
            if radioStations.count > 0 {
                ScrollView {
                    ForEach(items, id: \.self) { index in
                        LazyVStack{
                            LazyHStack {
                                CachedAsyncImage(url: URL(string: radioStations[index].image), content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                }, placeholder: {
                                    ProgressView()
                                })
                                Text(radioStations[index].tagline)
                                    .font(.caption)
                                    .lineLimit(3)
                                    .frame(width: 200)
                                
                                // Usando nueva classe checkFavoriteC
                                
                                Image(systemName: checkIfIsFavorite.manageData(data: radioStations[index].id, userSettings: userSettings) ? "star.fill" : "star")
                                    .foregroundColor(checkIfIsFavorite.manageData(data: radioStations[index].id, userSettings: userSettings) ? .yellow : .none)
                                
                                Spacer()
                                NavigationLink(destination: DetalleUIView(choice: radioStations[index].siteurl, selectedRadioStation: radioStations[index])) {
                                    Image(systemName: "arrow.forward.circle")
                                        .foregroundColor(Color.black.opacity(0.85))
                                }
                                .accessibilityValue(radioStations[index].id)
                            }
                            .padding(15)
                            .shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                            .background(Color.newPrimaryColor)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                        }
                        .opacity(isVStackVisible ? 1.0 : 0.0)
                        .animation(.easeIn(duration: 1.5), value: isVStackVisible)
                        .onAppear {
                            withAnimation {
                                isVStackVisible = true

                            }
                        }
                        
                    }
                    .navigationBarTitle("Radio App", displayMode: .inline)
                }
                
            }
            
        }.onAppear {
            if radioStations.isEmpty {
                radioStations = mYradioStation.loadStation()
            }
 
        }
        
    }
        

}



struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView()
    }
}

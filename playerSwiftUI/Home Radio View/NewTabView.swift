//
//  NewTabView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import SwiftUI

struct NewTabView: View {
    
    
    @AppStorage("ringtone") private var theFirstRadio = ""
    
    @State var radioStations: [radioStationInfo] = []
    @State private var isVStackVisible = false
    
    
    var body: some View {
        TabView {
            switch theFirstRadio {
            case "P2":
                NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStations[1])) {
                    Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStations[2])) {
                    Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStations[0])) {
                    Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
            case "P3":
                NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStations[2])) {
                    Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStations[0])) {
                    Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStations[1])) {
                    Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
            default:
                NavigationLink(destination: DetalleUIView(choice: "P1", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square" , imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter och aktualiteter, granskning och fördjupning men också livsåskådnings-och livsstilsprogram samt underhållning och upplevelser till exempel i form av teater.", siteurl: "https://sverigesradio.se/p1", url: "http://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))) {
                    Image("P1").accessibilityLabel("P1").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P2", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/163/2186754_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/163/2186754_512_512.jpg", color: "ff5a00", tagline: "P2 är den klassiska musikkanalen som även erbjuder jazz samt folk- och världsmusik. Digitalt sänder vi musikprogram dygnet runt, i FM finns även program på andra språk än svenska.", siteurl: "https://sverigesradio.se/p2", url: "http://sverigesradio.se/topsy/direkt/srapi/163.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=163", xmltvid:  "p2.sr.se", name: "P2", id: "163"))) {
                    Image("P2").accessibilityLabel("P2").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
                NavigationLink(destination: DetalleUIView(choice: "P3", selectedRadioStation: radioStationInfo(image: "https://static-cdn.sr.se/images/164/2186756_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/164/2186756_512_512.jpg", color: "19a972", tagline: "Kanalen för dig som gillar ny musik, livesänd radio och högkvalitativa poddar. Lyssna på P3 för populärkultur, samhällsjournalistik, musik och humor.", siteurl: "https://sverigesradio.se/p3", url: "http://sverigesradio.se/topsy/direkt/srapi/164.mp3", scheduleurl: "http://api.sr.se/v2/scheduledepisodes?channelid=164", xmltvid: "p3.sr.se", name: "P3", id: "164"))) {
                    Image("P3").accessibilityLabel("P3").cornerRadius(10).shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                }
            }
        }
        .tabViewStyle(.page)
        .background(Color.newColorGreenLight)
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .opacity(isVStackVisible ? 1.0 : 0.0)
        .animation(.easeIn(duration: 1.5), value: isVStackVisible)
        .onAppear {
            withAnimation {
                isVStackVisible = true
            }
        }
        
    }
}

struct NewTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewTabView()
    }
}

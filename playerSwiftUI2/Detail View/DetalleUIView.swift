//
//  DetalleUIView.swift
//  playerSwiftUI2
//
//  Created by Alvar Arias on 2022-12-18.
//

import SwiftUI

struct DetalleUIView: View {
    
    @State var choice : String
    @State var choice1 : DemoRadio
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "choice", choice1: DemoRadio(image:" https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square", imagetemplate: "https://static-cdn.sr.se/images/132/2186745_512_512.jpg", color: "31a1bd", tagline: "Talat innehåll om samhälle, kultur och vetenskap. Kanalen erbjuder nyheter \noch aktualiteter, granskning och fördjupning men också livsåskådnings-och \nlivsstilsprogram samt underhållning och upplevelser till exempel i form av \nteater.",siteurl: "http://api.sr.se/v2/scheduledepisodes?channelid=132", url:"https://sverigesradio.se/topsy/direkt/srapi/132.mp3", scheduleurl: "https://api.sr.se/v2/scheduledepisodes?channelid=132", xmltvid: "p1.sr.se", name: "P1", id: "132"))
    }
}

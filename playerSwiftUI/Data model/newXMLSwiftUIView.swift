//
//  XMLSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI


struct newXMLSwiftUIView: View {
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    
    @StateObject var parserControl = ParseController()

    let theFakeURL = "https://api.sr.se/v2/scheduledepisodes?channelid=132"
    
    var body: some View {
        VStack{
       
            if let itemsResult = parserControl.Schedule, !itemsResult.isEmpty {
                        List{
                            ForEach(1...3, id:\.self) {item in
                                Text(parserControl.Schedule[item].episodeTitle).listRowBackground(Color.newColorGreenLight)
                                
                            }
                        }.background(Color.newColorGreenLight)
                    
            }
        
            
        }.background(Color.newColorGreenLight)
        .onAppear(perform: {
            DispatchQueue.main.async { parserControl.loadData(theRadioURL: theFakeURL)
                
            }

        })
    }
}
    
struct newXMLSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        newXMLSwiftUIView()
    }
}



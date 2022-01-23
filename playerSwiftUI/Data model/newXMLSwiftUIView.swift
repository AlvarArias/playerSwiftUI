//
//  XMLSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI


struct newXMLSwiftUIView: View {
    
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    
    @StateObject var parserControl = ParseController()

    let theFakeURL = "https://api.sr.se/v2/scheduledepisodes?channelid=132"
    
    @EnvironmentObject var receivedURL: theURLSetting
    
    var myNewDate = theDateFormater()
    
    
    
    var body: some View {
        VStack{
       
            if let itemsResult = parserControl.Schedule, !itemsResult.isEmpty {
                        List{
                            ForEach(1...4, id:\.self) {item in
                                let myNewDateValue = myNewDate.transformDate(theProgramDate: parserControl.Schedule[item].episodeStarttimeutc)
                                Text(parserControl.Schedule[item].episodeTitle).listRowBackground(Color.newColorGreenLight).font(.title2)
                                Text(parserControl.Schedule[item].episodeDescription).listRowBackground(Color.newColorGreenLight).font(.body)
                                Text("Program time : \(myNewDateValue)").listRowBackground(Color.newColorGreenLight).font(.body)
                                    .listRowSeparator(.hidden)
                            }
                        }.background(Color.newColorGreenLight)
                    
            }
        
            
        }.background(Color.newColorGreenLight)
        .onAppear(perform: {
            //DispatchQueue.main.async { parserControl.loadData(theRadioURL: theFakeURL)
            DispatchQueue.main.async { parserControl.loadData(theRadioURL: receivedURL.theURL)
            
                myNewDate.transformDate(theProgramDate: "2022-01-23T08:03:00Z")
                
            }

        })
    }
}
    
struct newXMLSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        newXMLSwiftUIView()
    }
}



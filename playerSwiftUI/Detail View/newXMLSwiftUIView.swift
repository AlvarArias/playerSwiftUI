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

        VStack {
            ScrollView {
                if let itemsResult = parserControl.Schedule, !itemsResult.isEmpty {
                    ForEach(0...4, id: \.self) { index in
                        
                        let item = itemsResult[index]
                        let myNewDateValue = myNewDate.transformDate(theProgramDate: item.episodeStarttimeutc)
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text(item.episodeTitle)
                                    .font(.body)
                                Spacer()
                                Text(myNewDateValue)
                                    .font(.caption)
                            }
                                Text(item.episodeDescription)
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                        .padding()
                    }
                } else {
                    Text("Ingen information tillgänglig")
                }
            }
        }
        .background(Color.newColorGreenLight)


            .onAppear {
                DispatchQueue.main.async {
                    
                    CheckDate()
                }
            }
        
    }
    
    private func CheckDate(){
        
        parserControl.loadData(theRadioURL: receivedURL.theURL)
        print("receivedURL.theURL XML() \(receivedURL.theURL)")
    
        // Assign the returned result to a variable
        _ = myNewDate.transformDate(theProgramDate: "2022-01-23T08:03:00Z")

    }
    
}
    
struct newXMLSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        newXMLSwiftUIView()
    }
}



//
//  RadioObj.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2021-12-07.
//

import Foundation
import UIKit

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myChannellRAdio = try? newJSONDecoder().decode(MyChannellRAdio.self, from: jsonData)
// file radios.json
// informacion sacada de :
// https://api.sr.se/api/v2/channels
// https://api.sr.se/v2/channels?page=2 (proxima página)


import Foundation

// MARK: - MyRadioGen
struct MyRadioGen {
    let image, imagetemplate: String
    let color, tagline: String
    let siteurl: String
    let url: String
    let scheduleurl: String
    let channeltype: Channeltype
    let xmltvid: String
}


enum Channeltype {
    case lokalKanal
    case rikskanal
}



struct myRadio {
    let radioURL : String
    let chanelID : String
    let radioName : String
    let radioLogoName : String
}

/*
 //let url2  = URL.init(string:"https://sverigesradio.se/topsy/direkt/srapi/2562.mp3")
<channel id="213" name="P4 Blekinge">
<channel id="223" name="P4 Dalarna">
<channel id="205" name="P4 Gotland">


 <channel id="132" name="P1">
 https://api.sr.se/api/v2/channels/132
 http://sverigesradio.se/topsy/direkt/srapi/132.mp3

 <channel id="163" name="P2">
 https://api.sr.se/api/v2/channels/163
 https://sverigesradio.se/topsy/direkt/srapi/2562.mp3

 <channel id="164" name="P3">
 https://api.sr.se/api/v2/channels/164
 https://sverigesradio.se/topsy/direkt/srapi/164.mp3
 
 */

// test variable que pasa data del home to detail
class User: ObservableObject {
    @Published var score = 0
}

class User2: ObservableObject {
    @Published var image = "url test"
    @Published var imagetemplate: String?
    @Published var scheduleurl: String?
}

struct DemoRadio: Codable {
    let image: String
    let imagetemplate: String
    let color: String
    let tagline: String
    let siteurl: String
    let url: String
    let scheduleurl: String
    let xmltvid: String
}

//let myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios.json")

//let myRadioTest: [User2] = Bundle.main.decode([User2].self, from: "radios.json")

//
//  NewRadioObj.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2024-04-30.
//

import Foundation

struct RadioStation: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    let imagetemplate: String
    let color: String
    let tagline: String
    let siteurl: String
    let url: String
    let scheduleurl: String
    let xmltvid: String
}

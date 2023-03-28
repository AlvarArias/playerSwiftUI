//
//  Helper.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-12.
//


import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}


struct  myColor {
    static let newPrimaryColor = UIColor(named: "testSetColor")
    
}


/*
 /*
 extension Color {
     static let oldPrimaryColor = Color(UIColor.systemIndigo)
     static let newPrimaryColor = Color("Verde")
     static let newSecundaryColor = Color("Cafe 1")
     static let newTerciaryColor = Color("Cafe 2")
     static let newColorGrayLight = Color("Gris light")
     static let newColorGreenLight = Color("Verde light")
 }
 */

 */



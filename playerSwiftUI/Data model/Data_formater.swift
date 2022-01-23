//
//  Data_formater.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import Foundation
import UIKit


class theDateFormater {

    // The default timeZone on ISO8601DateFormatter is UTC.
    // Set timeZone to UTTimeZone.current to get local time.
    
    
    func transformDate (theProgramDate: String) -> String {
        
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "H:mm d-MMM-yy"
        
        let localDate = localISOFormatter.date(from: theProgramDate)
        
        print("The Date from String")
        print(localDate?.description ?? "no date")
        
        let resultString = inputFormatter.string(from: localDate!)
        print("New format")
        let final = String(resultString)
        print(final)
        
        return final
        
    }
    
}




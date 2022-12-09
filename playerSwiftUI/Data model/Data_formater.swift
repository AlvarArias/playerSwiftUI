//
//  Data_formater.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import Foundation
import UIKit

/// Data formater
///
/// This class transfor a ISO Data format to Date format
/// "H:mm d-MMM-yy"
class theDateFormater {
    
    func transformDate (theProgramDate: String) -> String {
        
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "H:mm d-MMM-yy"
        
        let localDate = localISOFormatter.date(from: theProgramDate)
        let resultString = inputFormatter.string(from: localDate!)
        let final = String(resultString)
       
        return final
    }
    
}



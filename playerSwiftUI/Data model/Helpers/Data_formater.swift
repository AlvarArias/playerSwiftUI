//
//  Data_formater.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import Foundation

struct DateTransformer {
    private let isoFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.timeZone = .current
        return f
    }()

    private let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "H:mm d-MMM-yy"
        return f
    }()

    func transformDate(theProgramDate: String) -> String {
        guard let date = isoFormatter.date(from: theProgramDate) else { return theProgramDate }
        return displayFormatter.string(from: date)
    }
}

// Legacy alias kept for any remaining callers
typealias theDateFormater = DateTransformer

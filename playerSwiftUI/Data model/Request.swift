//
//  Request.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-19.
//

import Foundation
import UIKit
import SwiftUI



struct scheduledEpisode {
    var episodeTitle: String
    var episodeDescription: String
    var episodeStarttimeutc: String
}



 class ParseController: NSObject, XMLParserDelegate, ObservableObject {
    @Published var Schedule: [scheduledEpisode] = []
    var elementName: String = String()
    var theEpisodeTitle = String()
    var theEpisodeDescription = String()
    var theStartTime = String()
    // https://api.sr.se/v2/scheduledepisodes?channelid=132
    
    
     func loadData(theRadioURL: String) {
         
         if (theRadioURL == "") { return } else {
        
        let semaphore = DispatchSemaphore (value: 0)
        

        var request = URLRequest(url: URL(string: theRadioURL)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
              Swift.print(String(describing: error))
            semaphore.signal()
            return
          }
            DispatchQueue.main.async {
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            }
            //print(self.Schedule)
            
            //print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
            
        }
        task.resume()
        semaphore.wait()
         
         }
             
        }
         
         
 
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
      
        if elementName == "scheduledepisode" {
            theEpisodeTitle = String()
            theEpisodeDescription = String()
            theStartTime = String()
        }
    
        self.elementName = elementName
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if elementName == "scheduledepisode" {
            
            let book = scheduledEpisode(episodeTitle: theEpisodeTitle, episodeDescription: theEpisodeDescription, episodeStarttimeutc: theStartTime)
            
            Schedule.append(book)
            

        }
       
        
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
                if self.elementName == "title" {
                    theEpisodeTitle += data
                } else if self.elementName == "description" {
                    theEpisodeDescription += data
                } else if self.elementName == "starttimeutc" {
                    theStartTime += data
                }
            }
    }
    

    
}
    

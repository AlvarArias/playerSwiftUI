//
//  TestSongView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-11-02.
//

import SwiftUI
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif



struct TestSongView: View {
    
    @StateObject private var vm = SongViewModel()
    
    @State var resultado2 : Song2
    
    
    var body: some View {
        VStack {
            Text("Test Song").font(.title)
                .padding()
            Button {
               
                callSong2()
             
                
            } label: {
                Image(systemName: "paperplane")
                .padding()
            }
        }
    }
    
   
    func callSong2() {
    
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://api.sr.se/api/v2/playlists/rightnow?channelid=164&format=JSON")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
                        
          let respString = String(data: data, encoding: .utf8)!
       
            let jsonData = respString.data(using: .utf8)!
            
            print(jsonData)
            
            let decodeJSON = try? JSONDecoder().decode(mySongNow2.self, from: jsonData)
            
            print("previoussong.title")
            print(decodeJSON?.playlist.previoussong?.title ?? "No previus song")
            print(decodeJSON?.playlist.previoussong?.description ?? "No description")
            print("song now")
            print(decodeJSON?.playlist.song?.title ?? "No song now")
            print(decodeJSON?.playlist.song?.description ?? "No description")
        
          semaphore.signal()
            
        }
        task.resume()
        semaphore.wait()
    }
    
   
    
    
}

struct TestSongView_Previews: PreviewProvider {
    static var previews: some View {
        TestSongView(resultado2: .init(title: "title", description: "description", artist: "artist", composer: "composer", conductor: "conductor", albumname: "albumname", recordlabel: "recordlabel", producer: "producer"))
    }
}


/**
 func callList() {
     
     var semaphore = DispatchSemaphore (value: 0)

     
     var request = URLRequest(url: URL(string: "https://api.sheetson.com/v2/sheets/Customers")!,timeoutInterval: Double.infinity)
     request.addValue("1YbIY2_EERJZC6mXao4OSu5UDG6lMCnw3CK49ZIE_2DE", forHTTPHeaderField: "X-Spreadsheet-Id")
     request.addValue("Bearer sfTZLA6FN9Zyr5x6M6LCgYbvluTeWzyzPz3jBBRUijCxH00nq8uPc7rH8AI", forHTTPHeaderField: "Authorization")

     request.httpMethod = "GET"

       let task = URLSession.shared.dataTask(with: request) { data, response, error in
       guard let data = data else {
         print(String(describing: error))
         semaphore.signal()
         return
     }
         
       //print(String(data: data, encoding: .utf8)!)
         
 
         let decodedResponse = try? JSONDecoder().decode(Welcome2.self, from: data)
         resultado = decodedResponse?.results ?? [Result(customerID: "11", nameCompany: "Test Cia", orgNumber: "11-22", contactName: "my Name", telephone: "0799999", email: "test email", rowIndex: 0)]
         //print(resultado)
         
         showList = true
         
         
       semaphore.signal()
     }

     task.resume()
     semaphore.wait()
     
 }
 
 
 */

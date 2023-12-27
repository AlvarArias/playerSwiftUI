//
//  network_checker.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//
import Foundation
import Network

 /// Check Network
///
///  Thsi class check if the network is valiable or not
final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
     
    @Published var isConnected = true
     
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}

struct mytest  {
    
    func validate(name: String) -> Bool{
        
        if name == "Alvar" {
            return false
        }
        
        return true
    }
    
}

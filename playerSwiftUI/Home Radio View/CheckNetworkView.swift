//
//  CheckNetworkView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import SwiftUI

struct CheckNetworkView: View {
    
    //Network check
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    
    var body: some View {
        VStack {
            // Network check
            if monitor.isConnected {
                Image(systemName: "wifi")
            } else {
                Image(systemName: "wifi.slash")
            }
        }.onAppear(){
            print("appear")
            if monitor.isConnected == false {
                self.showAlertSheet = true
            }
           
        }
        .alert(isPresented: $showAlertSheet, content: {
                    return Alert(title: Text("No Internet Connection"), message: Text("Please enable Wifi or Celluar data"), dismissButton: .default(Text("Cancel")))
                })
    }
}

struct CheckNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckNetworkView()
    }
}

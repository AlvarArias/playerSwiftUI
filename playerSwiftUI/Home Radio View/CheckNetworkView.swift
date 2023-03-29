//
//  CheckNetworkView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import SwiftUI
/// A view that displays a Wi-Fi or no Wi-Fi icon based on the current network connectivity status.
struct CheckNetworkView: View {
    
    /// An observed object that monitors the network connectivity status.
    @ObservedObject private var monitor = NetworkMonitor()
    /// A state variable that indicates whether to show an alert sheet when there is no network connection.
    @State private var showAlertSheet = false
    
    var body: some View {
        VStack {
            if monitor.isConnected {
                Image(systemName: "wifi")
            } else {
                Image(systemName: "wifi.slash")
            }
        }
        .onAppear {
            if !monitor.isConnected {
                showAlertSheet = true
            }
        }
        .alert(isPresented: $showAlertSheet) {
            Alert(title: Text("No Internet Connection"), message: Text("Please enable Wi-Fi or Cellular data"), dismissButton: .default(Text("Cancel")))
        }
    }
}


struct CheckNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckNetworkView()
    }
}



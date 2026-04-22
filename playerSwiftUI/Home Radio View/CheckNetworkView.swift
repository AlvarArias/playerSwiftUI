//
//  CheckNetworkView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import SwiftUI

struct CheckNetworkView: View {
    @Environment(NetworkMonitor.self) private var monitor
    @State private var showAlert = false

    var body: some View {
        Image(systemName: monitor.isConnected ? "wifi" : "wifi.slash")
            .onChange(of: monitor.isConnected) { _, connected in
                if !connected { showAlert = true }
            }
            .alert("Ingen internetanslutning", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Aktivera Wi-Fi eller mobildata")
            }
    }
}

#Preview {
    CheckNetworkView()
        .environment(NetworkMonitor())
}

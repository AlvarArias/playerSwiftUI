//
//  CheckNetworkView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-23.
//

import SwiftUI

struct CheckNetworkView: View {
    @Environment(StationStore.self) private var stationStore

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "wifi.slash")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)

            Text("Ingen internetanslutning")
                .font(.title2.weight(.semibold))

            Text("Kontrollera Wi-Fi eller mobildata och försök igen.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button {
                stationStore.load()
            } label: {
                Label("Försök igen", systemImage: "arrow.clockwise")
                    .padding(.horizontal, 8)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CheckNetworkView()
        .environment(StationStore())
}

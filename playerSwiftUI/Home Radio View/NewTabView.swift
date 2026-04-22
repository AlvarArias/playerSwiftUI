//
//  NewTabView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import SwiftUI

struct NewTabView: View {
    @Environment(StationStore.self) private var stationStore
    @Environment(UserSettings.self) private var userSettings
    @State private var isVisible = false

    private var featuredStations: [RadioStation] {
        let preferred = userSettings.preferredStation
        let featured = stationStore.stations.filter { ["P1", "P2", "P3"].contains($0.name) }
        return featured.sorted { a, b in
            if a.name == preferred { return true }
            if b.name == preferred { return false }
            return a.name < b.name
        }
    }

    var body: some View {
        TabView {
            ForEach(featuredStations) { station in
                NavigationLink(destination: DetalleUIView(station: station)) {
                    Image(station.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray, radius: 0.5, x: 0.5, y: -0.5)
                        .accessibilityLabel(station.name)
                }
            }
        }
        .tabViewStyle(.page)
        .background(Color.newColorGreenLight)
        .frame(height: 300)
        .opacity(isVisible ? 1.0 : 0.0)
        .animation(.easeIn(duration: 1.5), value: isVisible)
        .onAppear { isVisible = true }
    }
}

#Preview {
    NewTabView()
        .environment(StationStore())
        .environment(UserSettings())
}

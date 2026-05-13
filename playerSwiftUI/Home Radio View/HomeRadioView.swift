//
//  HomeRadioView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI

struct HomeRadioView: View {
    @AppStorage("username") private var theUserName = ""
    @Environment(NetworkMonitor.self) private var monitor
    @State private var showSettings = false
    @State private var showFavorites = false
    @State private var showSearch = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text(theUserName)

                NewTabView()

                if monitor.isConnected {
                    Text("Välj din radio")
                        .padding()
                        .accessibilityLabel("Välj din radio")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NewListView()
                } else {
                    CheckNetworkView()
                }
            }
            .background(Color.newColorGreenLight)
            .navigationTitle("Radio App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(Color.newSecundaryColor)
                    }

                    Spacer()

                    Button {
                        showFavorites.toggle()
                    } label: {
                        Image(systemName: "star")
                            .foregroundStyle(Color.newSecundaryColor)
                    }

                    Spacer()

                    Button {
                        showSearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .foregroundStyle(Color.newSecundaryColor)
                    }
                }
            }
            .sheet(isPresented: $showSettings) { SettingsView() }
            .sheet(isPresented: $showFavorites) { FavoriteDispView() }
            .sheet(isPresented: $showSearch) { SearchView() }
        }
    }
}

#Preview {
    HomeRadioView()
        .environment(StationStore())
        .environment(UserSettings())
        .environment(NetworkMonitor())
        .environment(PlayerViewModel())
}

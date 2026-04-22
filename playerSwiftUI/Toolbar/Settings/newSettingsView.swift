//
//  newSettingsView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import SwiftUI

struct SettingsView: View {
    @Environment(UserSettings.self) private var userSettings
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        @Bindable var settings = userSettings

        NavigationStack {
            Form {
                Section("Användarprofil") {
                    TextField("Användarnamn", text: $settings.username)

                    Text("Första radiohemmet")
                    Picker("Välj radio", selection: $settings.preferredStation) {
                        ForEach(userSettings.availableStations, id: \.self) { station in
                            Text(station)
                        }
                    }
                    Text("Vald radio: \(userSettings.preferredStation)")
                }
            }
            .navigationTitle("Spelarinställningar")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.newColorGrayLight)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button { dismiss() } label: { ArrowToolBarView() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(UserSettings())
}

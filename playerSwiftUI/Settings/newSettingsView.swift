//
//  newSettingsView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import SwiftUI

struct newSettingsView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("PROFILE")) {
                TextField("Username", text: $userSettings.username)
            
                /*
                Toggle(isOn: $userSettings.isPrivate){
                    Text("Private Account")
                }
                */
                Text("First radio home")
                
                Picker(selection: $userSettings.ringtone, label: Text("Ringtone")){
                    ForEach(userSettings.ringtones, id:\.self){ringtone in
                        Text(ringtone)
                    }
                    
                }
                //.pickerStyle(.segmented)
                //Text("Selected color: \(selectedColorIndex)")
            }
        }
        .navigationBarTitle("Player Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {dismiss()} label: {
                    Image(systemName: "arrow.down")
                    .foregroundColor(.newSecundaryColor)
                    
                    }
                }
            }
            
            
        }
     }
    }


struct newSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        newSettingsView()
    }
}

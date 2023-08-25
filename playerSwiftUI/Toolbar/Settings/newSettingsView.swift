//
//  newSettingsView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import SwiftUI
/*
class RefreshActionPerformer: ObservableObject {
    @Published private(set) var isPerforming = false

    func perform(_ action: RefreshAction) async {
        guard !isPerforming else { return }
        isPerforming = true
        await action()
        isPerforming = false
    }
}
*/

struct newSettingsView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.dismiss) var dismiss

    @State private var showing = false
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Användarprofil")) {
                TextField("Användarnamn", text: $userSettings.username)
            
                /*
                Toggle(isOn: $userSettings.isPrivate){
                    Text("Private Account")
                }
                */
                Text("Första radiohemmet")
                
                Picker(selection: $userSettings.ringtone, label: Text("Välj radio")){
                    ForEach(userSettings.ringtones, id:\.self){ringtone in
                        Text(ringtone)
                    }
                }
                Text("Vald radio: \(userSettings.ringtone)")
            }
        }
        .navigationBarTitle("Spelarinställningar")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.newColorGrayLight)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
               
                Button { dismiss() } label: {
                    ArrowToolBarView()
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

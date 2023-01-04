//
//  newSettingsView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-08-01.
//

import SwiftUI

class RefreshActionPerformer: ObservableObject {
    @Published private(set) var isPerforming = false

    func perform(_ action: RefreshAction) async {
        guard !isPerforming else { return }
        isPerforming = true
        await action()
        isPerforming = false
    }
}

struct newSettingsView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.dismiss) var dismiss

    @State private var showing = false
    
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
                
                Picker(selection: $userSettings.ringtone, label: Text("Select radio")){
                    ForEach(userSettings.ringtones, id:\.self){ringtone in
                        Text(ringtone)
                    }
                }
                Text("Selected radio: \(userSettings.ringtone)")
            }
        }
        .navigationBarTitle("Player Settings")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.newColorGrayLight)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                
                Button { //dismiss()
                    showing = true
                    
                } label: {
                    Image(systemName: "arrow.down")
                        .foregroundColor(Color.newSecundaryColor)
                    }
                .fullScreenCover(isPresented: $showing, content: SliderSwiftUIView.init)
               
                
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

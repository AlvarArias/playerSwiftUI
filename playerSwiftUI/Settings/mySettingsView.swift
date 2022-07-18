//
//  mySettingsView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-15.
//

import SwiftUI

struct mySettingsView: View {
    
    @State var username: String = ""
    @State var isPrivate: Bool = true
    
    @State var notoficationsEnabled: Bool = false
    @State private var previewIndex: Int = 0
    var previewOptions = ["Always", "When Unlocked", "Never"]
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
        Form {
            Section(header: Text(" my PROFILE")) {
                TextField("Input Username", text: $username)
                Toggle(isOn: $isPrivate) {
                    Text("Private Account")
                    
                }
            }
            
            Section(header: Text("Notifications")){
                Toggle(isOn: $notoficationsEnabled){
                    Text("Enabled")
                }
                Picker(selection: $previewIndex, label: Text("Show previews")){
                    ForEach(0 ..< previewOptions.count, id: \.self) {
                        Text(self.previewOptions[$0])
                    }
                }
                
            }
            
            Section(header: Text("about")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("2.1.3")
                }
            }
            
            
            Section {
                Button(action: {
                    print("Perform action here")
                }) {
                    Text("Reset all settings")
                }
            }
        }
        .navigationBarTitle("Player Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {dismiss() } label: {
                    Image(systemName: "arrow.down")
                    
                }
                }
       }
    }
    }
}

struct mySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        mySettingsView()
    }
}

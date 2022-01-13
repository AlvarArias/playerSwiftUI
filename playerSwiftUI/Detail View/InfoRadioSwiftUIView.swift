//
//  InfoRadioSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct InfoRadioSwiftUIView: View {
    
    @EnvironmentObject var user: User
    
    @EnvironmentObject var user2: User2
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    
    var body: some View {
        
        List {
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            //Text("User: \(user.score)")
            //Text("User: \(user2.image)")
            
        }.background(Color.newSecundaryColor)
     }
        
        
}


struct InfoRadioSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRadioSwiftUIView()
    }
}

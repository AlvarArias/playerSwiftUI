//
//  InfoRadioSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct InfoRadioSwiftUIView: View {
    
    //@EnvironmentObject var user: User
    
    //@EnvironmentObject var user2: User2
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    
    var body: some View {
        
        List {
            Text("Info radio ")
            Text("Info radio ")
            Text("Info radio ")
            Text("Info radio ")
        }
    
     }
    
        
}


struct InfoRadioSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRadioSwiftUIView()
    }
}

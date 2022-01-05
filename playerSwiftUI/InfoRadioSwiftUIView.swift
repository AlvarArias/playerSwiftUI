//
//  InfoRadioSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct InfoRadioSwiftUIView: View {
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    
    var body: some View {
        
        List {
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            Text("Info radio ").listRowBackground(Color.newSecundaryColor)
            
        }.background(Color.newSecundaryColor)
     }
        
        
}


struct InfoRadioSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRadioSwiftUIView()
    }
}

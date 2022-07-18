//
//  SerachView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-18.
//

import Foundation
import SwiftUI

struct SerachView: View {
    
    let names = ["Alvar","Juan","Martin"]
    @State private var searchText=""
    
    @State var items = 0...9
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios.json")
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                 
                List {
                    ForEach(searchResults, id: \.self) { name in
                       
                        HStack {
                           
                            AsyncImage(url: URL(string: name.image), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                            },
                            placeholder: {
                                ProgressView()
                            })
                            
                            Text(name.tagline).font(.body).lineLimit(3)
                                .frame(width: 200)
                          
                            NavigationLink(destination: DetalleUIView(choice: name.siteurl, choice1: name)) {
                                
                                Text("")
                            }
                            
                           
                        } .listRowSeparator(.hidden)
                        
                        
                    }
                    .navigationBarTitle("Radio App search", displayMode: .inline)
                }
            
                .searchable(text: $searchText,
                       placement: .navigationBarDrawer(displayMode: .always))
                
               }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Dismiss") {
                           dismiss() } 
                    }
           }
        }
    }
           var searchResults: [DemoRadio] {
               if searchText.isEmpty {
                   return myRadioDemo
               } else {
                   return myRadioDemo.filter { word in
                       word.tagline.contains(searchText)
               }
               
              
           }
       }

}
    
/*
struct SerachView_Previews: PreviewProvider {
    static var previews: some View {
        SerachView()
    }
}
*/
    
    



//
//  FavoritesSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-05.
//

import SwiftUI

struct FavoritesSwiftUIView: View {

    init(){
            UITableView.appearance().backgroundColor = .clear
        }

    var body: some View {

        VStack {
            
            Text("Favorites").font(.title)
        
           List {
               HStack {
                   Image(uiImage: UIImage(named: "P3")!).resizable()
                       .frame(width: 50.0, height: 50.0).clipShape(Circle()).opacity(0.9)
                       
                   Spacer()
                   
                   Text("Favorites")
                   
                   Spacer()
                   
                   Button(action: {
                             print("button pressed")

                           }) {
                               Image("But-Play2")
                                   .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original)).resizable().frame(width: 50, height: 50)
                           }
                   
                   
               }.listRowBackground(Color.newSecundaryColor)
               
               
              
               Text("Favorites").listRowBackground(Color.newSecundaryColor)
               Text("Favorites").listRowBackground(Color.newSecundaryColor)
               
           }.background(Color.newSecundaryColor)
        }
    }
}


struct FavoritesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSwiftUIView()
    }
}



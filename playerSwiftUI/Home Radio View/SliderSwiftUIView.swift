//
//  SliderSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI

struct SliderSwiftUIView: View {
    var body: some View {
       
        NavigationView {
        
        TabView {
            
            NavigationLink(destination: DetalleUIView(choice: "P1")) {
                Image("P1")
            }
            
            NavigationLink(destination: DetalleUIView(choice: "P1")) {
                Image("P2")
            }
            
            NavigationLink(destination: DetalleUIView(choice: "P3")) {
                Image("P3")
            }
       
        }
        .tabViewStyle(.page).foregroundColor(.white)
        .background(Color.newSecundaryColor)
        .frame(width: UIScreen.main.bounds.width, height: 300)
        }
    }
}
struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
}

/*
 Image(uiImage: UIImage(named:"P1")!).resizable().aspectRatio(contentMode: .fit).padding().onTapGesture {
     print("P1")}
     
 Image(uiImage: UIImage(named:"P2")!).resizable().aspectRatio(contentMode: .fit).padding().onTapGesture {
     print("P2") }
 
 Image(uiImage: UIImage(named:"P3")!).resizable().aspectRatio(contentMode: .fit).padding().onTapGesture {
     print("P3")}
 
 */

/*
 NavigationLink(destination: Text("DetalleUIView")){
     Image("P1")
 }
 
 NavigationLink(destination: Text("DetalleUIView")) {
     Image("P1")
 }
 
 NavigationLink(destination: Text("DetalleUIView")) {
         Image("P2")
 }
 
 NavigationLink(destination: Text("DetalleUIView")) {
         Image("P3")
 }
 */

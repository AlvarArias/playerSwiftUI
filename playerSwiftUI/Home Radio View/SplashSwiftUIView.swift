//
//  SplashSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI

struct SplashSwiftUIView: View {

    @State var isActive:Bool = false

    var body: some View {
        VStack {
            
            if self.isActive {
                
                SliderSwiftUIView()
                
            } else {
                
                Text("Wellcome").font(Font.largeTitle)
                Image("miRadio").resizable().aspectRatio(contentMode: .fit).padding().frame(height: 200)
                
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SplashSwiftUIView()
    }
}

/*
 // 1.
 @State var isActive:Bool = false
 
 var body: some View {
     VStack {
         // 2.
         if self.isActive {
             // 3.
             HomeView()
         } else {
             // 4.
             Text("Awesome Splash Screen!")
                 .font(Font.largeTitle)
         }
     }
     // 5.
     .onAppear {
         // 6.
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
             // 7.
             withAnimation {
                 self.isActive = true
             }
         }
     }
 }

 */

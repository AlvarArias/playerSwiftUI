//
//  SplashSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI

struct SplashSwiftUIView: View {

    @State var isActive:Bool = false
    @ObservedObject var userSettings = UserSettings()
   
    
    var body: some View {
        VStack {
            
            if self.isActive {
                
                SliderSwiftUIView()
                
            } else {
                
                Text("Wellcome").font(Font.largeTitle)
                Text(userSettings.username)
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


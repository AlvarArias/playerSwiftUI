//
//  SplashView.swift
//  newPlayerSwiftUI
//
//  Created by Alvar Arias on 2023-01-02.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    //@ObservedObject var userSettings = UserSettings()
    
    var body: some View {

        VStack {
            
            if self.isActive {
                
                // Next View
                SliderSwiftUIView()
                
            } else {
               
                Text("Välkommen").font(Font.largeTitle).accessibilityLabel("välkommen")
                //Text(userSettings.username)
                Image("miRadio").resizable().aspectRatio(contentMode: .fit).padding().frame(height: 200)
                    .accessibilityLabel("miRadio")
            }
            
        }
        .onAppear {
          
          
        }
       
    }
    /// Function Show the Screen
    ///
    /// This functin show the screen after delay of time
    ///  Use with .onApper {} on the view you will show after.
    func showNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation{
                self.isActive = true
            }
        }
    }
    
    
   }
        

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}


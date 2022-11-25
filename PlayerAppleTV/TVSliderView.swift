//
//  TVSliderView.swift
//  PlayerAppleTV
//
//  Created by Alvar Arias on 2022-11-21.
//

import SwiftUI

struct TVSliderView: View {
    
    var theFirstRadio = "P2"
    
    
    var body: some View {
        TabView {

                    Image("P2").accessibilityLabel("P2")
                
                    Image("P3").accessibilityLabel("P3")
                
                    Image("P1").accessibilityLabel("P1")
            }

        .tabViewStyle(.page).foregroundColor(Color.newPrimaryColor)
.background(Color.newColorGrayLight)
.frame(width: UIScreen.main.bounds.width, height: 300)
.onAppear {
    //tarea cuando aparece
}
        
    }
}

struct TVSliderView_Previews: PreviewProvider {
    static var previews: some View {
        TVSliderView()
    }
}

extension Color {
    //static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("Verde")
    static let newSecundaryColor = Color("Cafe 1")
    static let newTerciaryColor = Color("Cafe 2")
    static let newColorGrayLight = Color("Gris light")
    static let newColorGreenLight = Color("Verde light")
}


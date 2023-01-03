//
//  SliderSwiftUIView.swift
//  newPlayerSwiftUI
//
//  Created by Alvar Arias on 2023-01-02.
//

import SwiftUI
import CachedAsyncImage

struct SliderSwiftUIView: View {

    // Usa decode helper
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")
    
    var body: some View {
        NavigationView {
        
            VStack {
                
                Text("Home")
                
                TabView {
                        NavigationLink(destination: DetalleUIView(choice1: myRadioDemo[2])) {
                            Image("P3")
                    
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice1: myRadioDemo[0])) {
                                Image("P1")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice1: myRadioDemo[1])) {
                            Image("P2")
                        }
                        
                    }
                .tabViewStyle(.page)
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .background(Color.newPrimaryColor)
                
                HStack {
                    Text("Select your radio").padding()
                        .accessibilityLabel("Select your radio")
                }
                
            }
        }
    }
}

struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
    }
}

extension Color {
    static let newPrimaryColor = Color("Verde light")
}
    

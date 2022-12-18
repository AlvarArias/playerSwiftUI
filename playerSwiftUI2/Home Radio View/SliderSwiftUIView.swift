//
//  SliderSwiftUIView.swift
//  playerSwiftUI2
//
//  Created by Alvar Arias on 2022-12-18.
//

import SwiftUI

struct SliderSwiftUIView: View {
    
    @State var myRadioDemo: [DemoRadio] = Bundle.main.decode([DemoRadio].self, from: "radios23.json")
    
    @State var items = 0...51
    
    var body: some View {
    
        NavigationView {
          ScrollView {
                HStack {
                ScrollView(.vertical) {
                        NavigationLink(destination: DetalleUIView(choice: "P2", choice1: myRadioDemo[1])) {
                            Image("P2")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P3", choice1: myRadioDemo[2])) {
                            Image("P3")
                        }
                        
                        NavigationLink(destination: DetalleUIView(choice: "P1", choice1: myRadioDemo[0])) {
                            Image("P1")
                        }
                        
                }
        }
        .background(Color.newColorGrayLight)
        .frame(width: UIScreen.main.bounds.width, height: 300)
    
                VStack {
                    Text("Select your radio").padding()
              
                }
       
                    ForEach(items, id: \.self) { index in
                    
                        HStack {
                            VStack (alignment: .leading){
                                Text(myRadioDemo[index].name).font(.headline)
                            Text(myRadioDemo[index].tagline).font(.body).lineLimit(3)
                                //.frame(width: 200)
                                .font(.body)
                            }
                            
                            Spacer()
                        
                            NavigationLink(destination: DetalleUIView(choice: myRadioDemo[index].siteurl, choice1: myRadioDemo[index])) {
                                
                                //Text(">")
                                Image(systemName: "play")
                            }
                            
                            }
                            .padding()
                 
                           }
            
                    }
                .navigationBarTitle("Radio App", displayMode: .inline)
                
                }.background(Color.newColorGrayLight)
                           
            }
        
    }
        


struct SliderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSwiftUIView()
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
 


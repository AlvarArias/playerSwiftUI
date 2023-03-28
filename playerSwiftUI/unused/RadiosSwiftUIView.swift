//
//  RadiosSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-12.
//

import SwiftUI

struct RadiosSwiftUIView: View {
    
    @State var isSelect : Bool = false
   
    let myRadioDemo = Bundle.main.decode([DemoRadio].self, from: "radios.json")
   
    let items = 1...10
    
    let rows = [GridItem(.fixed(10))]
    
    var body: some View {
        ScrollView(.horizontal) {
          
            LazyHGrid(rows: rows, alignment: .top) {
                ForEach(items, id: \.self) { myIitem in
                    let localIndex = myIitem - 1
                    
                    VStack {
                        Text(String(localIndex))
                        Text(myRadioDemo[localIndex].xmltvid)
                        AsyncImage(url: URL(string: myRadioDemo[localIndex].image), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                 .frame(width: 200, height: 200)
                        },
                        placeholder: {
                            ProgressView()
                        })
                        
                            .onTapGesture{

                            isSelect.toggle()
                                print(myRadioDemo[localIndex].image)
                          
                        }
                    }.padding()
                 
                }
            }
            .frame(height: 350)

        }.background(Color.newPrimaryColor)
    }
}

struct RadiosSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RadiosSwiftUIView()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

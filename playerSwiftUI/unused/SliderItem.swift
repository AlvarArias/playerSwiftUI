//
//  SliderItem.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-13.
//

import SwiftUI

struct SliderItem: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named:"P1")!).resizable().aspectRatio(contentMode: .fit).padding().onTapGesture {
                print("P1")}
        }
        //NavigationLink("", destination: DetalleUIView(choice: "P1")
    }
}

struct SliderItem_Previews: PreviewProvider {
    static var previews: some View {
        SliderItem()
    }
}

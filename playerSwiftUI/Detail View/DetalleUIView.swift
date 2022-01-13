//
//  DetalleUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-11.
//

import SwiftUI

struct DetalleUIView: View {
    
    var choice: String
    
    var body: some View {
        Text("Your Choice is \(choice)")
    }
}

struct DetalleUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleUIView(choice: "test")
    }
}

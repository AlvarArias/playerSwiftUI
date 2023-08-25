//
//  ArrowToolBarView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2023-08-25.
//

import SwiftUI

struct ArrowToolBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Image(systemName: "arrow.down")
     .foregroundColor(Color.newSecundaryColor)
    }
}

struct ArrowToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowToolBarView()
    }
}

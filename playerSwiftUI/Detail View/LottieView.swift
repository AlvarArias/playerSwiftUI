//
//  LottieView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-29.
//

import SwiftUI
import Lottie

struct LottieView: View {
    let lottieFile: String

    var body: some View {
        Lottie.LottieView(animation: .named(lottieFile))
            .playing(loopMode: .loop)
    }
}

#Preview {
    LottieView(lottieFile: "music-equalizer")
        .frame(width: 100, height: 100)
}

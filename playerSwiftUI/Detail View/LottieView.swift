//
//  LottieView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-07-29.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let lottieFile: String

    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: lottieFile)
        view.loopMode = .loop
        view.play()
        view.contentMode = .scaleAspectFit
        return view
    }

    func updateUIView(_ uiView: AnimationView, context: Context) {}
}

#Preview {
    LottieView(lottieFile: "music-equalizer")
        .frame(width: 100, height: 100)
}

//
//  SplashSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.
//

import SwiftUI

struct SplashSwiftUIView: View {
    @Environment(UserSettings.self) private var userSettings
    @State private var isActive = false
    @State private var opacity = 0.0

    var body: some View {
        if isActive {
            HomeRadioView()
        } else {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .accessibilityLabel("Welcome")
                Text(userSettings.username)
                Image("miRadio")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(height: 200)
                    .accessibilityLabel("miRadio")
            }
            .opacity(opacity)
            .task {
                withAnimation(.easeIn(duration: 2.0)) { opacity = 1.0 }
                try? await Task.sleep(for: .seconds(2.5))
                withAnimation { isActive = true }
            }
        }
    }
}

#Preview {
    SplashSwiftUIView()
        .environment(UserSettings())
}

//
//  SplashSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.

import SwiftUI


struct SplashSwiftUIView: View {
    @State private var isActive = false
    @ObservedObject private var userSettings = UserSettings()
    
    var body: some View {
        VStack {
            if isActive {
                SliderSwiftUIView()
            } else {
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
        }
        .onAppear {
            showNextScreen()
        }
    }
    
    private func showNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                isActive = true
            }
        }
    }
}


struct SplashSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SplashSwiftUIView()
    }
}


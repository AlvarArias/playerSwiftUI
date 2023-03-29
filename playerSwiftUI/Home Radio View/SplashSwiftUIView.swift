//
//  SplashSwiftUIView.swift
//  playerSwiftUI
//
//  Created by Alvar Arias on 2022-01-17.

import SwiftUI


struct SplashSwiftUIView: View {
    
    @ObservedObject private var userSettings = UserSettings()
    
    @State private var isActive = false
    @State private var isVStackVisible = false

    var body: some View {
        VStack {
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
                .opacity(isVStackVisible ? 1.0 : 0.0)
                .animation(.easeIn(duration: 2.0), value: isVStackVisible)
                .onAppear {
                    withAnimation {
                        isVStackVisible = true
                    }
                }
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


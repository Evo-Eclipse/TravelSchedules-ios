//
//  SplashView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var themeManager = ThemeManager.shared
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Image(.screenSplash)
                    .resizable()
                    .ignoresSafeArea()
            }
            .preferredColorScheme(themeManager.colorScheme)
            .onAppear {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}

//
//  TravelSchedulesApp.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 05.09.2025.
//

import SwiftUI

@main
struct TravelSchedulesApp: App {
    @State private var themeManager = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}

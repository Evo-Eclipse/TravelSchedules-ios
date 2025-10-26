//
//  ContentView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 05.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var tripSelection = TripSelection()
    @State private var navigator = AppNavigator()
    @State private var themeManager = ThemeManager.shared
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .environment(tripSelection)
                .tabItem {
                    Image(.iconSchedule)
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    Image(.iconSettings)
                }
                .tag(1)
        }
        .tint(Color(.yBlack))
        .environment(navigator)
        .environment(themeManager)
        .preferredColorScheme(themeManager.colorScheme)
    }
}

#Preview {
    ContentView()
}

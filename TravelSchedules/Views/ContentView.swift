//
//  ContentView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 05.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
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
    }
}

#Preview {
    ContentView()
}

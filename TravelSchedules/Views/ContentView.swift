//
//  ContentView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 05.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchScheduleBetweenStations()
        }
    }
}

#Preview {
    ContentView()
}

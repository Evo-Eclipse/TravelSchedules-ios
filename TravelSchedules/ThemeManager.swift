//
//  ThemeManager.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import SwiftUI

@Observable final class ThemeManager {
    static let shared = ThemeManager()
    
    private init() {
        self.selectedTheme = ThemeStorage.shared.selectedTheme
    }
    
    var selectedTheme: ThemeStorage.Theme {
        didSet {
            ThemeStorage.shared.selectedTheme = selectedTheme
        }
    }
    
    var colorScheme: ColorScheme {
        selectedTheme == .dark ? .dark : .light
    }
    
    func toggleTheme() {
        selectedTheme = selectedTheme == .dark ? .light : .dark
    }
}

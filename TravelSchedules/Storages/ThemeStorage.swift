//
//  ThemeStorage.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 17.10.2025.
//

import Foundation

@MainActor
final class ThemeStorage {
    static let shared = ThemeStorage()
    private let key = "selectedTheme"
    
    enum Theme: String, CaseIterable {
        case light
        case dark
    }
    
    private init() {}
    
    var selectedTheme: Theme {
        get {
            if let storedValue = UserDefaults.standard.string(forKey: key),
               let theme = Theme(rawValue: storedValue) {
                return theme
            }
            return .light // Default theme
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
}

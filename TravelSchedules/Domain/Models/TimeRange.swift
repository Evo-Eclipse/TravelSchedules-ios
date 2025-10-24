//
//  TimeRange.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 12.10.2025.
//

import Foundation

enum TimeRange: String, CaseIterable, Hashable {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    
    func contains(hour: Int) -> Bool {
        switch self {
        case .morning: return hour >= 6 && hour < 12
        case .afternoon: return hour >= 12 && hour < 18
        case .evening: return hour >= 18 && hour < 24
        case .night: return hour >= 0 && hour < 6
        }
    }
}

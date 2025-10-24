//
//  Date+Age.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension Date {
    var age: TimeInterval { Date().timeIntervalSince(self) }
}

//
//  RouteStop.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Stop
//

import Foundation

struct RouteStop: Hashable, Sendable {
    let arrival: Date?
    let departure: Date?
    let stopTimeSec: Int?
    let durationToSec: Double?
    let terminal: String?
    let platform: String?
    let station: Station
}

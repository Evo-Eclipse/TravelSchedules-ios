//
//  TripSegment.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Segment
//

import Foundation

struct TripSegment: Hashable, Sendable {
    let id: String
    let from: Station
    let to: Station // swiftlint:disable:this identifier_name
    let departure: Date?
    let arrival: Date?
    let departureTime: String?  // Raw time string from API (e.g., "13:30:00")
    let arrivalTime: String?    // Raw time string from API (e.g., "15:10:00")
    let startDate: String?      // Raw date string from API (e.g., "2025-10-13")
    let durationSec: Int?
    let thread: ThreadSummary?
    let tickets: TicketsInfo?
    let hasTransfers: Bool
}

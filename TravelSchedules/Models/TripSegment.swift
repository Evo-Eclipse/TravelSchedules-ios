//
//  TripSegment.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Segment
//

import Foundation

struct TripSegment: Hashable {
    let id: String
    let from: Station
    let to: Station // swiftlint:disable:this identifier_name
    let departure: Date?
    let arrival: Date?
    let durationSec: Int?
    let thread: ThreadSummary?
    let tickets: TicketsInfo?
}

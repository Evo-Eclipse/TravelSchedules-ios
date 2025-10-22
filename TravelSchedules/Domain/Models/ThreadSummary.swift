//
// ThreadSummary.swift
// TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Thread
//

import Foundation

struct ThreadSummary: Hashable, Sendable {
    let uid: String?
    let number: String?
    let title: String?
    let carrier: Carrier?
    let transportType: TransportType?
    let vehicle: String?
    let startTime: String?
    let days: String?
    let interval: IntervalInfo?

    struct IntervalInfo: Hashable, Sendable {
        let density: String?
        let beginTime: String?
        let endTime: String?
    }
}

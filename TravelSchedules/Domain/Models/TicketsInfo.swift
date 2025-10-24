//
//  TicketsInfo.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.TicketsInfo
//

import Foundation

struct TicketsInfo: Hashable, Sendable {
    let eticket: Bool?
    let places: [Place]

    struct Place: Hashable, Sendable {
        let name: String?
        let price: Price?
    }
}

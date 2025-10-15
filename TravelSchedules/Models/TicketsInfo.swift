//
//  TicketsInfo.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.TicketsInfo
//

import Foundation

struct TicketsInfo: Hashable {
    let eticket: Bool?
    let places: [Place]

    struct Place: Hashable {
        let name: String?
        let price: Price?
    }
}

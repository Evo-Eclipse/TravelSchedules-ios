//
//  TicketsInfo+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension TicketsInfo {
    init(_ ticketsInfo: Components.Schemas.TicketsInfo) {
        let places: [TicketsInfo.Place] = (ticketsInfo.places ?? []).map { apiPlace in
            let price = apiPlace.price.flatMap(Price.init)

            return TicketsInfo.Place(
                name: apiPlace.name,
                price: price
            )
        }

        self.init(
            eticket: ticketsInfo.et_marker,
            places: places
        )
    }
}

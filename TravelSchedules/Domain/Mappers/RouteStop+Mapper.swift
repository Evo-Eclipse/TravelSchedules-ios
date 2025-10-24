//
//  RouteStop+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension RouteStop {
    init?(_ stop: Components.Schemas.Stop) {
        guard let apiStation = stop.station, let station = Station(apiStation, cityCode: nil) else { return nil }
        let arrivalDate = stop.arrival.flatMap(DateParsing.parseISO8601)
        let departureDate = stop.departure.flatMap(DateParsing.parseISO8601)

        self.init(
            arrival: arrivalDate,
            departure: departureDate,
            stopTimeSec: stop.stop_time,
            durationToSec: stop.duration,
            terminal: stop.terminal,
            platform: stop.platform,
            station: station
        )
    }
}

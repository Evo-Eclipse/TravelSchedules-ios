//
//  TripSegment+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension TripSegment {
    init?(_ segment: Components.Schemas.Segment) {
        guard
            let apiFrom = segment.from,
            let apiTo = segment.to
        else { return nil }
        guard
            let fromStation = Station(apiFrom, cityCode: nil),
            let toStation = Station(apiTo, cityCode: nil)
        else { return nil }

        let departureDate = segment.departure.flatMap(DateParsing.parseISO8601)
        let arrivalDate = segment.arrival.flatMap(DateParsing.parseISO8601)
        let threadSummary = segment.thread.map { ThreadSummary($0) }
        let ticketsInfo = segment.tickets_info.map { TicketsInfo($0) }
        let threadUID = segment.thread?.uid ?? UUID().uuidString
        let departureKey = segment.departure ?? ""
        let id = threadUID + "_" + departureKey
        
        // In standard segments, the field "has_transfers" is absent, always false.
        let hasTransfers = false

        self.init(
            id: id,
            from: fromStation,
            to: toStation,
            departure: departureDate,
            arrival: arrivalDate,
            departureTime: segment.departure,
            arrivalTime: segment.arrival,
            startDate: segment.start_date,
            durationSec: segment.duration,
            thread: threadSummary,
            tickets: ticketsInfo,
            hasTransfers: hasTransfers
        )
    }
}

//
//  ThreadSummary+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension ThreadSummary {
    init(_ thread: Components.Schemas.Thread) {
        let carrierModel = thread.carrier.map { Carrier($0) }
        let intervalInfo = thread.interval.map {
            ThreadSummary.IntervalInfo(
                density: $0.density,
                beginTime: $0.begin_time,
                endTime: $0.end_time
            )
        }
        let transportType = thread.transport_type.flatMap(TransportType.init(rawValue:)) ?? .unknown

        self.init(
            uid: thread.uid,
            number: thread.number,
            title: thread.title,
            carrier: carrierModel,
            transportType: transportType,
            vehicle: thread.vehicle,
            startTime: thread.start_time,
            days: thread.days,
            interval: intervalInfo
        )
    }
}

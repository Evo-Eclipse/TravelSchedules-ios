//
//  Station+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension Station {
    init?(_ station: Components.Schemas.Station, cityCode: String?) {
        let code = station.code ?? station.codes?.yandex_code
        guard let code else { return nil }
        let title = station.title ?? code
        let transportType: TransportType = station.transport_type.flatMap(TransportType.init(rawValue:)) ?? .unknown
        let stationType: StationType? = {
            guard let raw = station.station_type else { return nil }
            return StationType(rawValue: raw) ?? .unknown
        }()

        self.init(
            code: code,
            title: title,
            cityCode: cityCode,
            lat: station.lat,
            lng: station.lng,
            transportType: transportType == .unknown ? nil : transportType,
            stationType: stationType,
            stationTypeName: station.station_type_name,
            esrCode: station.codes?.esr_code,
            direction: station.direction,
            majority: station.majority,
            distanceKm: station.distance
        )
    }
}

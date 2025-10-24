//
//  Station.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Station
//

import Foundation

struct Station: Hashable, Sendable {
    let code: String
    let title: String
    let cityCode: String?
    let lat: Double?
    let lng: Double?
    let transportType: TransportType?
    let stationType: StationType?
    let stationTypeName: String?
    let esrCode: String?
    let direction: String?
    let majority: Int?
    let distanceKm: Double?

    enum StationType: String {
        case station
        case platform
        case stop
        case checkpoint
        case post
        case crossing
        case overtakingPoint = "overtaking_point"
        case trainStation = "train_station"
        case airport
        case busStation = "bus_station"
        case busStop = "bus_stop"
        case port
        case portPoint = "port_point"
        case wharf
        case riverPort = "river_port"
        case marineStation = "marine_station"
        case unknown
    }
}

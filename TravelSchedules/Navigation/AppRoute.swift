//
//  AppRoute.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 14.10.2025.
//

import Foundation

enum AppRoute: Hashable {
    case cityPicker(Direction)
    case stationPicker(city: City, direction: Direction)
    case schedules(from: Station, to: Station)
}

enum Direction: Hashable {
    case from
    case to
}

//
//  City.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Settlement
//  Components.Schemas.ResponseNearestCity
//

import Foundation

struct City: Hashable {
    let code: String
    let title: String
    let lat: Double?
    let lng: Double?
    let distanceKm: Double?
    let kind: Kind

    enum Kind: String {
        case settlement
        case station
        case unknown
    }
}

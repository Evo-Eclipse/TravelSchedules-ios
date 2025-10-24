//
//  City+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension City {
    init?(_ settlement: Components.Schemas.Settlement) {
        guard let code = settlement.codes?.yandex_code else { return nil }
        let title = settlement.title ?? code

        self.init(
            code: code,
            title: title,
            lat: nil,
            lng: nil,
            distanceKm: nil,
            kind: .settlement
        )
    }

    init?(_ responseCity: Components.Schemas.ResponseNearestCity) {
        guard let code = responseCity.code else { return nil }
        let title = responseCity.popular_title ?? responseCity.title ?? responseCity.short_title ?? code
        let kind: City.Kind = switch responseCity._type?.lowercased() {
        case "settlement": .settlement
        case "station": .station
        default: .unknown
        }

        self.init(
            code: code,
            title: title,
            lat: responseCity.lat,
            lng: responseCity.lng,
            distanceKm: responseCity.distance,
            kind: kind
        )
    }
}

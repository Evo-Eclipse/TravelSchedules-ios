//
//  Carrier.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Carrier
//

import Foundation

struct Carrier: Hashable, Sendable {
    let code: String?
    let title: String?
    let logoURL: URL?
    let url: URL?
    let phone: String?
    let email: String?
    let contacts: String?
    let address: String?
    let codes: Codes?

    struct Codes: Hashable, Sendable {
        let icao: String?
        let iata: String?
        let sirena: String?
    }
}

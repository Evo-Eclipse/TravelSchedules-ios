//
//  Carrier+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension Carrier {
    init(_ carrier: Components.Schemas.Carrier) {
        let logoURL = carrier.logo.flatMap { URL(string: $0) }
        let siteURL = carrier.url.flatMap { URL(string: $0) }
        let codes = Codes(
            icao: carrier.codes?.icao,
            iata: carrier.codes?.iata,
            sirena: carrier.codes?.sirena
        )

        self.init(
            code: carrier.code.map(String.init),
            title: carrier.title,
            logoURL: logoURL,
            url: siteURL,
            phone: carrier.phone,
            email: carrier.email,
            contacts: carrier.contacts,
            address: carrier.address,
            codes: codes
        )
    }
}

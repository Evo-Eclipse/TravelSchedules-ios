//
//  CopyrightInfo+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension CopyrightInfo {
    init?(_ payload: Components.Schemas.Copyright) {
        guard let url = URL(string: payload.url) else { return nil }
        var logos: [URL] = []
        [
            payload.logo_vm,
            payload.logo_vd,
            payload.logo_hy,
            payload.logo_hd,
            payload.logo_vy,
            payload.logo_hm
        ]
        .forEach { logoString in
            if let logoString, let logoURL = URL(string: logoString) {
                logos.append(logoURL)
            }
        }

        self.init(
            url: url,
            text: payload.text,
            logos: logos
        )
    }
}

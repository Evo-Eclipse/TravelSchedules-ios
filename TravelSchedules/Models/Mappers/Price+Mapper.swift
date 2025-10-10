//
//  Price+Mapper.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

extension Price {
    init?(_ price: Components.Schemas.Price?) {
        guard let price else { return nil }
        let amountMinor = (price.whole ?? 0) * 100 + (price.cents ?? 0)

        self.init(
            currency: price.currency,
            amountMinor: amountMinor
        )
    }
}

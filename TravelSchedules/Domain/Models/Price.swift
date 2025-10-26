//
//  Price.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 07.10.2025.
//
//  Components.Schemas.Price
//

import Foundation

struct Price: Hashable, Sendable {
    let currency: String?
    let amountMinor: Int?
}

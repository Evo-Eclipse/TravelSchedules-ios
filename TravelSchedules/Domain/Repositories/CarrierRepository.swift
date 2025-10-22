//
//  CarrierRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

final class CarrierRepository: @unchecked Sendable {
    private let carrierService: CarrierInfoServiceProtocol
    private let cacheTTL: TimeInterval = 24 * 60 * 60 // 1d

    private var cache: [String: (value: Carrier, timestamp: Date)] = [:]

    init(service: CarrierInfoServiceProtocol) {
        carrierService = service
    }

    func carrier(code: String) async throws -> Carrier? {
        if let cached = cache[code], cached.timestamp.age <= cacheTTL {
            return cached.value
        }

        let response = try await carrierService.fetchCarrierInfo(code: code)
        let apiCarrier: Components.Schemas.Carrier? = response.carrier ?? response.carriers?.first

        guard let apiCarrier else {
            return nil
        }

        let model = Carrier(apiCarrier)
        cache[code] = (model, Date())

        return model
    }

    func carriers(from segments: [TripSegment]) -> [Carrier] {
        var seen: Set<String> = []
        var result: [Carrier] = []

        for segment in segments {
            guard let carrier = segment.thread?.carrier else { continue }

            let key = carrier.code ?? carrier.title ?? UUID().uuidString
            if !seen.contains(key) {
                seen.insert(key)
                result.append(carrier)
            }
        }

        return result
    }
}

//
//  CopyrightRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

actor CopyrightRepository {
    private enum ErrorType: Error {
        case missingPayload, invalidURL
    }

    private let copyrightService: CopyrightServiceProtocol
    private let cacheTTL: TimeInterval = 24 * 60 * 60 // 1d

    private var cache: (value: CopyrightInfo, timestamp: Date)?

    init(service: CopyrightServiceProtocol) {
        copyrightService = service
    }

    func copyright() async throws -> CopyrightInfo {
        if let cached = cache, cached.timestamp.age <= cacheTTL {
            return cached.value
        }

        let response = try await copyrightService.fetchCopyright()
        guard let payload = response.copyright else {
            throw ErrorType.missingPayload
        }

        guard let result = CopyrightInfo(payload) else {
            throw ErrorType.invalidURL
        }

        cache = (result, Date())
        return result
    }
}

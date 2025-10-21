//
//  ThreadRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

final class ThreadRepository {
    private let routeStationsService: RouteStationsServiceProtocol
    private let cacheTTL: TimeInterval = 30 * 60 // 30m

    private var cache: [String: (value: [RouteStop], timestamp: Date)] = [:]

    init(service: RouteStationsServiceProtocol) {
        routeStationsService = service
    }

    func routeStops(threadUID: String) async throws -> [RouteStop] {
        if let cached = cache[threadUID], cached.timestamp.age <= cacheTTL {
            return cached.value
        }

        let response = try await routeStationsService.fetchRouteStations(uid: threadUID)
        let stops = (response.stops ?? []).compactMap { RouteStop($0) }

        cache[threadUID] = (stops, Date())
        return stops
    }
}

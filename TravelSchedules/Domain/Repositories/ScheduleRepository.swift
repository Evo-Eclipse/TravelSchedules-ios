//
//  ScheduleRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

final class ScheduleRepository {
    private let scheduleService: ScheduleBetweenStationsServiceProtocol
    private let cacheTTL: TimeInterval = 10 * 60 // 10m

    private var cache: [String: (value: [TripSegment], timestamp: Date)] = [:]

    init(scheduleService: ScheduleBetweenStationsServiceProtocol) {
        self.scheduleService = scheduleService
    }

    func searchSegments(from originCode: String, to destinationCode: String) async throws -> [TripSegment] {
        let key = "\(originCode)->\(destinationCode)"
        if let cached = cache[key], cached.timestamp.age <= cacheTTL {
            return cached.value
        }

        let response = try await scheduleService.fetchScheduleBetweenStations(from: originCode, to: destinationCode)
        let segments = (response.segments ?? []).compactMap { TripSegment($0) }

        cache[key] = (segments, Date())
        return segments
    }
}

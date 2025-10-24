//
//  StationRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

actor StationRepository {
    private let allStationsService: AllStationsServiceProtocol
    private let nearestStationsService: NearestStationsServiceProtocol

    private var allStationsSnapshot: (value: Components.Schemas.ResponseAllStations, timestamp: Date)?
    private var stationsByCityCache: [String: (value: [Station], timestamp: Date)] = [:]
    private var nearestCache: [String: (value: [Station], timestamp: Date)] = [:]

    private let ttlByCity: TimeInterval = 7 * 24 * 60 * 60 // 7d
    private let ttlNearest: TimeInterval = 10 * 60 // 10m

    init(allStationsService: AllStationsServiceProtocol, nearestStationsService: NearestStationsServiceProtocol) {
        self.allStationsService = allStationsService
        self.nearestStationsService = nearestStationsService
    }

    func stations(in cityCode: String, forceReload: Bool = false) async throws -> [Station] {
        if !forceReload, let cache = stationsByCityCache[cityCode], cache.timestamp.age <= ttlByCity {
            return cache.value
        }

        let responseAllStations: Components.Schemas.ResponseAllStations
        if let snapshot = allStationsSnapshot, snapshot.timestamp.age <= ttlByCity {
            responseAllStations = snapshot.value
        } else {
            let fetched = try await allStationsService.fetchAllStations()
            allStationsSnapshot = (fetched, Date())
            responseAllStations = fetched
        }

        let countries = responseAllStations.countries ?? []
        let regions = countries.flatMap { $0.regions ?? [] }
        let settlements = regions.compactMap(\.settlements).flatMap(\.self)

        guard let settlement = settlements.first(where: { $0.codes?.yandex_code == cityCode }) else {
            stationsByCityCache[cityCode] = ([], Date())
            return []
        }

        let stations = (settlement.stations ?? []).compactMap { Station($0, cityCode: cityCode) }
        stationsByCityCache[cityCode] = (stations, Date())
        return stations
    }

    func nearestStations(lat: Double, lng: Double, distanceKm: Int, limit: Int = 100) async throws -> [Station] {
        let key = "lat:\(lat)_lng:\(lng)_d:\(distanceKm)"
        if let cache = nearestCache[key], cache.timestamp.age <= ttlNearest {
            return cache.value
        }

        let response = try await nearestStationsService.fetchNearestStations(lat: lat, lng: lng, distance: distanceKm)
        let result = (response.stations ?? []).compactMap { Station($0, cityCode: nil) }
        let limited = Array(result.prefix(limit))

        nearestCache[key] = (limited, Date())
        return limited
    }

    func searchStations(cityCode: String, query: String, limit: Int = 50) async throws -> [Station] {
        let stations = try await stations(in: cityCode)
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Array(stations.prefix(limit))
        }

        let lower = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return stations
            .filter {
                $0.title.lowercased().contains(lower) ||
                    $0.code.lowercased().contains(lower)
            }
            .prefix(limit)
            .map(\.self)
    }
}

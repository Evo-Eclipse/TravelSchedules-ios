//
//  CityRepository.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.10.2025.
//

import Foundation

actor CityRepository {
    private let allStationsService: AllStationsServiceProtocol
    private let nearestCityService: NearestCityServiceProtocol

    private var allStationsSnapshot: (value: Components.Schemas.ResponseAllStations, timestamp: Date)?
    private var allCitiesCache: (value: [City], timestamp: Date)?
    private let cacheTTL: TimeInterval = 7 * 24 * 60 * 60 // 7d

    init(allStationsService: AllStationsServiceProtocol, nearestCityService: NearestCityServiceProtocol) {
        self.allStationsService = allStationsService
        self.nearestCityService = nearestCityService
    }

    func allCities(forceReload: Bool = false) async throws -> [City] {
        if !forceReload, let cache = allCitiesCache, cache.timestamp.age <= cacheTTL {
            return cache.value
        }

        let responseAllStations: Components.Schemas.ResponseAllStations
        if let snapshot = allStationsSnapshot, snapshot.timestamp.age <= cacheTTL {
            responseAllStations = snapshot.value
        } else {
            let fetched = try await allStationsService.fetchAllStations()
            allStationsSnapshot = (fetched, Date())
            responseAllStations = fetched
        }

        let countries = responseAllStations.countries ?? []
        let regions = countries.flatMap { $0.regions ?? [] }
        let settlements = regions.flatMap { $0.settlements ?? [] }
        let cities = settlements.compactMap { City($0) }

        allCitiesCache = (cities, Date())
        return cities
    }

    func searchCities(query: String, limit: Int = 30) async -> [City] {
        let source = (allCitiesCache?.value) ?? []
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Array(source.prefix(limit))
        }

        let lower = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return source
            .filter {
                $0.title.lowercased().contains(lower) ||
                    $0.code.lowercased().contains(lower)
            }
            .prefix(limit)
            .map(\.self)
    }

    func nearestCity(lat: Double, lng: Double) async throws -> City? {
        let apiCity = try await nearestCityService.fetchNearestCity(lat: lat, lng: lng)
        return City(apiCity)
    }
}

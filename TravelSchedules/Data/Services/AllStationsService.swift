//
//  AllStationsService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.ResponseAllStations

protocol AllStationsServiceProtocol: Sendable {
    func fetchAllStations() async throws -> AllStations
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())

        let responseBody = try response.ok.body.html

        let limit = 50 * 1024 * 1024 // 50Mb
        let fullData = try await Data(collecting: responseBody, upTo: limit)

        let allStations = try JSONDecoder().decode(AllStations.self, from: fullData)

        return allStations
    }
}

// Smoke test: AllStationsService

func testFetchAllStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = AllStationsService(client: client)

            print("Fetching all stations...")

            let allStations = try await service.fetchAllStations()

            let countries = allStations.countries ?? []
            let regions = countries.flatMap { $0.regions ?? [] }
            let settlements = regions.flatMap { $0.settlements ?? [] }
            let stations = settlements.flatMap { $0.stations ?? [] }

            print("Successfully fetched all stations: \(stations.count)")
            print("With countries: \(countries.count), regions: \(regions.count), settlements: \(settlements.count)")
        } catch {
            print("Failed to fetch all stations: \(error)")
        }
    }
}

// End of smoke test

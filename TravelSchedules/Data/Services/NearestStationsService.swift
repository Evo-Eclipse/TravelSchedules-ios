//
//  NearestStationsService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 06.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func fetchNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))

        return try response.ok.body.json
    }
}

// Smoke test: NearestStationsService

func testFetchNearestStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = NearestStationsService(client: client)

            print("Fetching stations...")

            let stations = try await service.fetchNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )

            print("Successfully fetched stations: \(stations)")
        } catch {
            print("Failed to fetch stations: \(error)")
        }
    }
}

// End of smoke test

//
//  NearestCityService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCity = Components.Schemas.ResponseNearestCity

protocol NearestCityServiceProtocol {
    func fetchNearestCity(lat: Double, lng: Double) async throws -> NearestCity
}

final class NearestCityService: NearestCityServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchNearestCity(lat: Double, lng: Double) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            lat: lat,
            lng: lng
        ))

        return try response.ok.body.json
    }
}

// Smoke test: NearestCityService

func testFetchNearestCity() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = NearestCityService(client: client)

            print("Fetching nearest city...")

            let nearestCity = try await service.fetchNearestCity(
                lat: 59.864177,
                lng: 30.319163
            )

            print("Successfully fetched nearest city: \(nearestCity)")
        } catch {
            print("Failed to fetch nearest city: \(error)")
        }
    }
}

// End of smoke test

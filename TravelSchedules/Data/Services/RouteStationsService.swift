//
//  RouteStationsService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ResponseThreadStations

protocol RouteStationsServiceProtocol: Sendable {
    func fetchRouteStations(uid: String) async throws -> RouteStations
}

final class RouteStationsService: RouteStationsServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchRouteStations(uid: String) async throws -> RouteStations {
        let response = try await client.getRouteStations(query: .init(
            uid: uid
        ))

        return try response.ok.body.json
    }
}

// Smoke test: RouteStationsService

func testFetchRouteStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = RouteStationsService(client: client)

            print("Fetching route stations...")

            let routeStations = try await service.fetchRouteStations(
                uid: "FV-6807_251014_c8565_12"
            )

            print("Successfully fetched route stations: \(routeStations)")
        } catch {
            print("Failed to fetch route stations: \(error)")
        }
    }
}

// End of smoke test

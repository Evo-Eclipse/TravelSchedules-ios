//
//  ScheduleBetweenStationsService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 10.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol: Sendable {
    // swiftlint:disable:next identifier_name
    func fetchScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    // swiftlint:disable:next identifier_name
    func fetchScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: from,
            to: to
        ))

        return try response.ok.body.json
    }
}

// Smoke test: ScheduleBetweenStationsService

func testFetchScheduleBetweenStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = ScheduleBetweenStationsService(client: client)

            print("Fetching schedule between stations...")

            let schedule = try await service.fetchScheduleBetweenStations(
                from: "s9600213", // SVO
                to: "s9600366" // LED
            )

            print("Successfully fetched schedule: \(schedule)")
        } catch {
            print("Failed to fetch schedule: \(error)")
        }
    }
}

// End of smoke test

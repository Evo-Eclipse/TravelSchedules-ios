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

protocol ScheduleBetweenStationsServiceProtocol {
    func fetchScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func fetchScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))

        return try response.ok.body.json
    }
}

// Example usage of the service

func testFetchScheduleBetweenStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport()
            )

            let service = ScheduleBetweenStationsService(
                client: client,
                apikey: apiKey
            )

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

// End of example usage

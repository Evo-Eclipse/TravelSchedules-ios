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
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func fetchNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))

        return try response.ok.body.json
    }
}

// Example usage of the service

func testFetchNearestStations() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport()
            )

            let service = NearestStationsService(
                client: client,
                apikey: apiKey
            )

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

// End of example usage

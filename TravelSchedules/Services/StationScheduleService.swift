//
//  StationScheduleService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ResponseSchedule

protocol StationScheduleServiceProtocol {
    func fetchStationSchedule(station: String) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func fetchStationSchedule(station: String) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))

        return try response.ok.body.json
    }
}

// Smoke test: StationScheduleService

func testFetchStationSchedule() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = StationScheduleService(
                client: client,
                apikey: apiKey
            )

            print("Fetching station schedule...")

            let stationSchedule = try await service.fetchStationSchedule(
                station: "s9600213" // SVO
            )

            print("Successfully fetched station schedule: \(stationSchedule)")
        } catch {
            print("Failed to fetch station schedule: \(error)")
        }
    }
}

// End of smoke test

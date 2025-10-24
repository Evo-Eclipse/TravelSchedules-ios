//
//  CarrierInfoService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.ResponseCarrier

protocol CarrierInfoServiceProtocol: Sendable {
    func fetchCarrierInfo(code: String) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchCarrierInfo(code: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            code: code
        ))

        return try response.ok.body.json
    }
}

// Smoke test: CarrierInfoService

func testFetchCarrierInfo() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = CarrierInfoService(client: client)

            print("Fetching carrier info...")

            let carrierInfo = try await service.fetchCarrierInfo(
                code: "8565" // Russia
            )

            print("Successfully fetched carrier info: \(carrierInfo)")
        } catch {
            print("Failed to fetch carrier info: \(error)")
        }
    }
}

// End of smoke test

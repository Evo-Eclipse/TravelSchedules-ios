//
//  CopyrightService.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 11.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.ResponseCopyright

protocol CopyrightServiceProtocol: Sendable {
    func fetchCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init())

        return try response.ok.body.json
    }
}

// Smoke test: CopyrightService

func testFetchCopyright() {
    Task {
        do {
            let apiKey = Constants.apiKey

            let client = try APIClientProvider.make(apiKey: apiKey)

            let service = CopyrightService(client: client)

            print("Fetching copyright...")

            let copyright = try await service.fetchCopyright()

            print("Successfully fetched copyright: \(copyright)")
        } catch {
            print("Failed to fetch copyright: \(error)")
        }
    }
}

// End of smoke test

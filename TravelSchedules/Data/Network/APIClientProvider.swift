//
//  APIClientProvider.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 15.09.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum APIClientProvider {
    static func make(apiKey: String) throws -> Client {
        try Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [
                YandexApiKeyMiddleware(apiKey: apiKey)
            ]
        )
    }
}

//
//  YandexApiKeyMiddleware.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 15.09.2025.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

struct YandexApiKeyMiddleware: ClientMiddleware {
    let apiKey: String

    func intercept(
        _ request: HTTPTypes.HTTPRequest,
        body: OpenAPIRuntime.HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: @Sendable (
            HTTPTypes.HTTPRequest,
            OpenAPIRuntime.HTTPBody?,
            URL
        ) async throws -> (
            HTTPTypes.HTTPResponse,
            OpenAPIRuntime.HTTPBody?
        )
    ) async throws -> (
        HTTPTypes.HTTPResponse,
        OpenAPIRuntime.HTTPBody?
    ) {
        var request = request
        request.headerFields[.authorization] = "\(apiKey)"
        return try await next(request, body, baseURL)
    }
}
